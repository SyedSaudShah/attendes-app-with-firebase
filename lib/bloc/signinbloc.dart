import 'package:attendes/bloc/signinevent.dart';
import 'package:attendes/bloc/signinstate.dart';
import 'package:attendes/screens/auth/authiaction.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<FetchsigninEvent>((event, emit) async {
      emit.call(SignInLoadingState());
      try {
        User? user = await signIn(event.email, event.password);
        emit(SignInLoadedState(user));
      } on FirebaseAuthException catch (e) {
        emit(SignInErrorState(e.toString()));
      } catch (e) {
        emit(SignInErrorState(e.toString()));
      }
    });
    on<GoogleEvent>((event, emit) async {
      emit.call(SignInLoadingState());
      try {
        User? userCredential = await signinWithGoogle();
        if (userCredential != null) {
          emit(GoogleSuccessFulState());
        }
      } catch (e) {
        emit(SignInErrorState(e.toString()));
      }
    });
  }
}
