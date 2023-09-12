part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpLoadedState extends SignUpState {
  final User? user;
  SignUpLoadedState(this.user);
}

class SignUpErrorState extends SignUpState {
  final String error;
  SignUpErrorState(this.error);
}
