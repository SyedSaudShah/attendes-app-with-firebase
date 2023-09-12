import 'dart:async';

import 'package:attendes/screens/splash_screen.dart';
import 'package:attendes/screens/student.dart';
import 'package:attendes/screens/studentcategory.dart';
import 'package:flutter/material.dart';
import 'package:attendes/bloc/sign_up_bloc.dart';
import 'package:attendes/bloc/signinbloc.dart';
import 'package:attendes/screens/auth/authiaction.dart';
import 'package:attendes/screens/enroll.dart';
import 'package:attendes/screens/studentlogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/image_dart_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(),
          ),
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(),
          ),
          BlocProvider<ImageDartBloc>(
              create: (context) => ImageDartBloc()
          ),
        ],
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple
      ),
      title: 'flutter',
      home: MyApp(),
    ));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value){
      if(FirebaseAuth.instance.currentUser == null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Studentlogin()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentCategery()));
      }
    });
    // Future.delayed(Duration(seconds: 3))
    //     .then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>SignInPage()), (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      body: Container(
        height: myHeight,
        width: myWidth,
        child: Center(
          child: Text(
            'SplashScreen'
          ),
        ),
      ),
    ));
  }
}



//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.delayed(Duration(seconds: 3)).then((value){
//       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignUpPage()), (route) => false);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double myHeight = MediaQuery.of(context).size.height;
//     double myWidth = MediaQuery.of(context).size.width;
//     return MultiBlocProvider(
//         providers: [
//           BlocProvider<SignInBloc>(
//             create: (context) => SignInBloc(),
//           ),
//           BlocProvider<SignUpBloc>(
//             create: (context) => SignUpBloc(),
//           ),
//           BlocProvider<ImageDartBloc>(
//               create: (context) => ImageDartBloc()
//           ),
//         ],
//         child: MaterialApp(
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//           ),
//           home: Scaffold(
//             body: Container(
//               height: myHeight,
//               width: myWidth,
//               child: Center(child: Text('Splash Screen'),),
//             ),
//           ),
//           //  auth.currentUser != null
//           //     ? const Enroll()
//           //     : const SignUpPage()
//         ));
//   }
// }
