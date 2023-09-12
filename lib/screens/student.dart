import 'package:attendes/bloc/signinbloc.dart';
import 'package:attendes/bloc/signinevent.dart';
import 'package:attendes/bloc/signinstate.dart';
import 'package:attendes/modal/checkConnection.dart';
import 'package:attendes/screens/studentcategory.dart';
import 'package:attendes/screens/studentlogin.dart';
import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

class Studentlogin extends StatefulWidget {
  const Studentlogin({super.key});

  @override
  State<Studentlogin> createState() => _StudentloginState();
}

class _StudentloginState extends State<Studentlogin> {
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  final GlobalKey key = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> emailGlobalKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> passwordGlobalKey =
      GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    SignInBloc signInBloc = Provider.of(context, listen: false);
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Form(
          key: key,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text('Log In'),
                  Container(
                    width: myWidth / 1.5,
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Some Text';
                        }
                      },
                      // onChanged: (value) {
                      //   emailGlobalKey.currentState!.validate();
                      // },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Enter Email',
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: myWidth / 1.5,
                    child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter correct password';
                        }
                      },
                      // onChanged: (value) {
                      //   passwordGlobalKey.currentState!.validate();
                      // },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'Enter Password',
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async{
                        // if (emailGlobalKey.currentState!.validate()  &&passwordGlobalKey.currentState!.validate()) {
                        bool check = await CheckConnection.checkInternet(context);
                        if(check){
                          signInBloc.add(FetchsigninEvent(
                              email.text.trim(), password.text.trim()));
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Connection Error')));
                        }

                        // }
                      },
                      child: const Text('Sign in')),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: myWidth / 1.5,
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: (myWidth / 1.5) / 7,
                            ),
                            const Text('Login with google')
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('If already have an account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const SignUpPage();
                          },
                        ));
                      },
                      child: const Text(
                        'Sign up',
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const Studentlogin(),
        BlocBuilder<SignInBloc, SignInState>(
          builder: (context, state) {
            if (state is SignInInitial) {
              return const SizedBox();
            } else if (state is SignInLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SignInLoadedState) {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const StudentCategery();
                  },
                ));
              });
              return const SizedBox();
            } else if (state is SignInErrorState) {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                Center(
                  child: Text(state.error),
                );
              });
              return const SizedBox();
            } else {
              return const SizedBox();
            }
          },
        )
      ]),
    );
  }
}
