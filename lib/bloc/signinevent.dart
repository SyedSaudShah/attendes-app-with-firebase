import 'package:flutter/material.dart';

@immutable
abstract class SignInEvent {}

class FetchsigninEvent extends SignInEvent {
  String email;
  String password;
  FetchsigninEvent(this.email, this.password);
}

class GoogleEvent extends SignInEvent {}
