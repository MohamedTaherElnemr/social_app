import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/components/message_on_screeen.dart';
import 'package:social_app/shared/network/cache_helper.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      CacheHelper.setData(key: 'uId', value: value.user!.uid);
      uId = value.user!.uid;
      emit(RegisterSuccess());
      showMessage(message: 'Registred Successe', state: ToastState.SUCCESS);
    }).catchError((error) {
      emit(RegisterFailed(error.toString()));
    });
  }

  createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    emit(CreateUserLoading());
    UserModel usermodel = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        cover:
            'https://img.freepik.com/free-photo/user-profile-icon-front-side-with-white-background_187299-40010.jpg?w=740&t=st=1689162494~exp=1689163094~hmac=72b42945f39e6d68bb83b6531327abb3e62865299cc605972ad0f71ba07f5ead',
        image:
            'https://img.freepik.com/free-photo/user-profile-icon-front-side-with-white-background_187299-40010.jpg?w=740&t=st=1689162494~exp=1689163094~hmac=72b42945f39e6d68bb83b6531327abb3e62865299cc605972ad0f71ba07f5ead',
        bio: 'write your bio ... ');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(usermodel.toMap())
        .then((value) {
      emit(CreateUserSuccess());
    }).catchError((error) {
      emit(CreateUserFailed(error.toString()));
    });
  }
}
