import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utilities/consts.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialState());
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscure = true;
  IconData visibilityIcon = Icons.visibility_off;
  
  void viewPassword() {
    obscure = !obscure;
    if (!obscure) {
      visibilityIcon = Icons.visibility;
    } else {
      visibilityIcon = Icons.visibility_off;
    }

    emit(PasswordVisibilityState());
  }

  String? errorMessageForLoggingIn;
  signInWithEmailAndPassword() async {
    emit(LoadingState());
   try {
      
      await firebaseInstance.signInWithEmailAndPassword(
          email: emailAddressController.text,
          password: emailAddressController.text);
      emit(SuccessState());
    }  on FirebaseAuthException catch (e) {
      
    
      errorMessageForLoggingIn = e.message;
      emit(FailureState());
    }
  }
  

  updateUI() {
    emit(UpdateUI());
  }

  void clearingData() {
    emailAddressController.clear();

    passwordController.clear();
  }
}
