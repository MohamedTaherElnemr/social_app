import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:social_app/shared/components/message_on_screeen.dart';
import 'package:social_app/shared/network/cache_helper.dart';

import '../../shared/components/constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  // var uId;

  void userLogin({required String email, required String password}) {
    emit(LoginLoading());
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        emit(LoginSuccess(value.user!.uid));
        CacheHelper.setData(key: 'uId', value: value.user!.uid);
        uId = value.user!.uid;
        showMessage(message: 'Login Success', state: ToastState.SUCCESS);
        showMessage(message: uId, state: ToastState.WARNING);
      }).catchError((error) {
        emit(LoginIFailed(error.toString()));
      });
    } catch (e) {
      showMessage(message: '$e', state: ToastState.ERROR);
      print(e);
    }
  }
}
