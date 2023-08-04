part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {}

class GetUserDataLoading extends SocialState {}

class GetUserDataSuccess extends SocialState {}

class GetUserDataFailed extends SocialState {
  final String errMessage;

  GetUserDataFailed(this.errMessage);
}

////////bottom nav///////////////////////////////////////////////////

class ChangeBottomNavState extends SocialState {}
//////////*******new post  *///////////////////////////////////////////////

class NewPostState extends SocialState {}

////****picking  image  */////////////////////////////////////////////////////////////
///
class ProfileImagePickedSuccessState extends SocialState {}

class ProfileImagePickedFailedState extends SocialState {}

class CoverImagePickedFailedState extends SocialState {}

class CoverImagePickedSuccessState extends SocialState {}

////***uploading images to firebase storage */////////////////////////////////////////////

class ProfileImageUpdatedSuccessState extends SocialState {}

class ProfileImageUpdatedFailedState extends SocialState {}

class CoverImageUpdatedSuccessState extends SocialState {}

class CoverImageUpdatedFailedState extends SocialState {}

//////////////////////////////***Create post States***///////////////////////////////////////////////////////

class CreatePostLoadingState extends SocialState {}

class CreatePostSuccessState extends SocialState {}

class CreatePostFailedState extends SocialState {}

class PostImagePickedSuccessState extends SocialState {}

class PostImagePickedFailedState extends SocialState {}

class PostImageuploadSuccessState extends SocialState {}

class PostImageuploadFailedState extends SocialState {}

class RemovePostImageSuccessState extends SocialState {}

/////////////////////**Get posts////////////////////// */

class GetPostsLoadingState extends SocialState {}

class GetPostsSuccessState extends SocialState {}

class GetPostsFailedState extends SocialState {
  final String error;

  GetPostsFailedState(this.error);
}
//////////////////**post likes* */

class PostLikeSuccessState extends SocialState {}

class PostLikeFailedState extends SocialState {
  final String error;

  PostLikeFailedState(this.error);
}

///////*****comment a post  */

class PostCommentSuccessState extends SocialState {}

class PostCommentFailedState extends SocialState {
  final String error;

  PostCommentFailedState(this.error);
}

/////**all users for chat */

class GetAllUsersSuccessState extends SocialState {}

class GetAllUsersLoadingState extends SocialState {}

class GetAllUsersFailedState extends SocialState {
  final String error;

  GetAllUsersFailedState(this.error);
}

////////////////////////// messages states //////////////////////////////////////////

class SendMessageLoadingState extends SocialState {}

class SendMessageSuccessState extends SocialState {}

class SendMessageFailedState extends SocialState {
  final String error;

  SendMessageFailedState(this.error);
}

class GetMessageSuccessState extends SocialState {}
