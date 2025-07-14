import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_journal/services/auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginCubit(this._authService) : super(LoginInitial());

  Future<void> signInWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());
      try {
        User? user = await _authService.signInWithEmailAndPassword(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        if (user != null) {
          emit(LoginSuccess(user));
        } else {
          emit(LoginFailure('Could not sign in with those credentials.'));
        }
      } catch (e) {
        emit(LoginFailure('An unexpected error occurred.'));
      }
    }
  }

  void navigateToForgotPassword() {
    emit(LoginNavigateToForgotPassword());
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}