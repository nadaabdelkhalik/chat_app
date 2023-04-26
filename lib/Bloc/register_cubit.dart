import 'package:bloc/bloc.dart';
import 'package:chat_app/Bloc/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Utilities/consts.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialState());
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  XFile? pickedProfileFile;
  XFile? pickedBackGroundFile;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController messagesController = TextEditingController();

  IconData passwordVisibilityIcon = Icons.visibility_off;
  IconData confirmPasswordVisibilityIcon = Icons.visibility_off;

  String? errorMessageForSigningUp;
  signUpWithEmailAndPassword() async {
    emit(LoadingState());
    try {
      UserCredential authResult =
          await firebaseInstance.createUserWithEmailAndPassword(
              email: emailAddressController.text,
              password: emailAddressController.text);

      FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set({
        'displayName': firstNameController.text,
        'email': emailAddressController.text,
        'password': passwordController.text,
        'uid': firebaseInstance.currentUser?.uid,
        'imageURL': imageURL
      });
      emit(SuccessState());
    } on FirebaseAuthException catch (e) {
      errorMessageForSigningUp = e.message;
      emit(FailureState());
    }
  }

  void viewPassword() {
    obscurePassword = !obscurePassword;
    if (!obscurePassword) {
      passwordVisibilityIcon = Icons.visibility;
    } else {
      passwordVisibilityIcon = Icons.visibility_off;
    }

    emit(PasswordVisibilityState());
  }

  void viewConfirmedPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    if (!obscureConfirmPassword) {
      confirmPasswordVisibilityIcon = Icons.visibility;
    } else {
      confirmPasswordVisibilityIcon = Icons.visibility_off;
    }

    emit(PasswordVisibilityState());
  }

  void clearingData() {
    firstNameController.clear();
    lastNameController.clear();
    emailAddressController.clear();
    passwordController.clear();
    confirmController.clear();
    messagesController.clear();
    pickedBackGroundFile = null;
    pickedProfileFile = null;
  }

  void changeState() {
    emit(UpdateUIState());
  }
}
