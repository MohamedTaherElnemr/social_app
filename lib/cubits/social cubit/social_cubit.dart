import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/internal%20screens/chat_screen.dart';
import 'package:social_app/modules/internal%20screens/feeds_screen.dart';
import 'package:social_app/modules/internal%20screens/settings_screen.dart';
import 'package:social_app/modules/internal%20screens/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/components/message_on_screeen.dart';
import 'package:social_app/shared/network/cache_helper.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  UserModel? userModel;

  void getUserData() {
    emit(GetUserDataLoading());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccess());
    }).catchError((error) {
      emit(GetUserDataFailed(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }

    if (index == 0) {
      getPosts();
    }

    if (index == 3) {
      getUserData();
    }
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];
  ////////////////////////***Picking Image  */

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      emit(ProfileImagePickedFailedState());
      print(' no image selected');
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      emit(CoverImagePickedFailedState());
      print(' no image selected');
    }
  }

  /////////////////////////**UPloading Images**///////////////////////////////////

  Future<void> uploadProfileImage(
      {required String name,
      required String phone,
      required String bio}) async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      emit(ProfileImageUpdatedSuccessState());

      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, image: value);
        showMessage(message: 'Profile Updated', state: ToastState.SUCCESS);
      }).catchError((error) {});
    }).catchError((error) {
      emit(ProfileImageUpdatedFailedState());
      showMessage(message: '$error', state: ToastState.SUCCESS);
    });
  }

  Future<void> uploadCoverImage(
      {required String name,
      required String phone,
      required String bio}) async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      emit(CoverImageUpdatedSuccessState());
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        showMessage(message: 'Profile Updated', state: ToastState.SUCCESS);
      }).catchError((error) {});
    }).catchError((error) {
      emit(CoverImageUpdatedFailedState());
      showMessage(message: '$error', state: ToastState.SUCCESS);
    });
  }

  void updateUser(
      {required String name,
      required String phone,
      required String bio,
      String? cover,
      String? image}) {
    UserModel usermodel = UserModel(
        name: name,
        phone: phone,
        email: userModel!.email,
        cover: cover ?? userModel!.cover,
        image: image ?? userModel!.image,
        bio: bio);

    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel.uId)
        .update(usermodel.toMap())
        .then((value) {
      getUserData();
      showMessage(message: 'Profile updated', state: ToastState.SUCCESS);
    }).catchError((erorr) {
      showMessage(
          message: 'user info not updated , try again later',
          state: ToastState.ERROR);
    });
  }

  ///////////////////////////**Create Post Functions **/////////////////////////////////

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      emit(PostImagePickedFailedState());
    }
  }

  void removePostImage() {
    postImage == null;
    emit(RemovePostImageSuccessState());
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      emit(PostImageuploadSuccessState());
      value.ref.getDownloadURL().then((value) {
        createPost(text: text, dateTime: dateTime, postImage: value);
      }).catchError((error) {});
    }).catchError((error) {
      emit(PostImageuploadFailedState());
    });
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel postModel = PostModel(
        name: userModel!.name,
        uId: userModel!.uId,
        image: userModel!.image,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? '');

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      CreatePostSuccessState();
      showMessage(message: 'post created', state: ToastState.SUCCESS);
    }).catchError((erorr) {
      emit(CreatePostFailedState());
      showMessage(message: '$Error', state: ToastState.ERROR);
    });
  }

  ////////get posts//////////**** *//////////////////////////////////////////////////////////////////////

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<int> comments = [];
  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});

        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
        }).catchError((error) {});
      });
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsFailedState(error.toString()));
    });
  }

  void likePost(String postid) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(PostLikeSuccessState());
    }).catchError((error) {
      emit(PostLikeFailedState(error.toString()));
    });
  }

  void commentpost(String postId, String comment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({'comment': '${comment}'}).then((value) {
      emit(PostCommentSuccessState());
    }).catchError((error) {
      emit(PostCommentFailedState(error.toString()));
    });
  }
//////////////////////////////////////**get all users *///////////////////////////////////////////////////

  List<UserModel> users = [];
  void getUsers() {
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != userModel!.uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      });
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersFailedState(error.toString()));
    });
  }

  ////////////////////////////// send message ////////////////////////////////////////////////////////////////

  void sendMessage({
    required String recieverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
        senderId: userModel!.uId!,
        recieverId: recieverId,
        dateTime: dateTime,
        text: text);

    //set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageFailedState(error.toString()));
    });

    // set reciever chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageFailedState(error.toString()));
    });
  }

  //////////////// get messages /////////////////////////////////////////////////////////////////////

  List<MessageModel> messages = [];

  void getMessages({required String recieverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });
  }
}
