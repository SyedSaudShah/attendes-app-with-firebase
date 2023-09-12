import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInLoadedState extends SignInState {
  final User? user;
  SignInLoadedState(this.user);
}

class GoogleSuccessFulState extends SignInState {}

class SignInErrorState extends SignInState {
  final String error;
  SignInErrorState(this.error);
}
