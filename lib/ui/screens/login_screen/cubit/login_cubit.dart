import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../shared/helper/mangers/constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  bool isPassword = true;

  void changePasswordVisibalty() {
    isPassword = !isPassword;
    emit(ChangePasswordVisibiltyState());
  }

  void signInUser() {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: "admin@gmail.com", password: "123456")
        .then((user) {
      FirebaseMessaging.instance.getToken().then((token) {
        FirebaseFirestore.instance
            .collection("admin")
            .doc("admin")
            .update({"token": token, "id": user.user!.uid});
      });
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState(errorMsg: error.toString()));
    });
  }
}
