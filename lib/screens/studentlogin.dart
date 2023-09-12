import 'dart:io';

import 'package:attendes/bloc/image_dart_bloc.dart';
import 'package:attendes/bloc/sign_up_bloc.dart';
import 'package:attendes/screens/studentcategory.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> nameGlobal = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> emailGlobal = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> passwordGlobal = GlobalKey<FormFieldState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var url;


  ImagePicker imagePicker = ImagePicker();

  File? image;
  Future<File?> pickImage(BuildContext context) async {

    var pick = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pick != null) {
      image = File(pick.path);
      context.read<ImageDartBloc>().add(ImageEvent(file: image!));
      return image;
    } else {
      const Text('data');
    }
    return image;
  }

  FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> uploadPic() async {
    //Get the file from the image picker and store it
    //File image = (await ImagePicker.pickImage(source: ImageSource.gallery)) as File;

    //Create a reference to the location you want to upload to in firebase
    var reference = _storage.ref().child(image!.path.toString());

    //Upload the file to firebase
    var uploadTask = reference.putFile(image!);

    // Waits till the file is uploaded then stores the download url
    //Uri location = (await uploadTask.future).downloadUrl;
    var dowurl = await (await uploadTask).ref.getDownloadURL();
    url = dowurl.toString();

    //returns the download url
    return url;
  }

  @override
  Widget build(BuildContext context) {
    SignUpBloc signUpBloc = Provider.of(context, listen: false);

    FirebaseStorage _storage = FirebaseStorage.instance;

    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
      child: Form(
          key: key,
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text('Wellcome'),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                    pickImage(context);
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: BlocBuilder<ImageDartBloc,ImageDartState>(
                    builder: (context,state){
                      if(state is ImageDartInitial){
                        return CircleAvatar(
                            child: Icon(Icons.camera_alt_outlined),
                              );
                      }else if(state is ImageState){
                        return CircleAvatar(
                                backgroundImage: FileImage(state.file),);
                      }else{
                        return CircleAvatar(
                              child: Icon(Icons.camera_alt_outlined),
                                );
                      }
                    },
                  )
                ),
              )

    //       image == null
    //   ? CircleAvatar(
    //   child: Icon(Icons.camera_alt_outlined),
    //     )
    //         : CircleAvatar(
    //     backgroundImage: FileImage(image!),
    // ),

              // GestureDetector(
              //     onTap: () {
              //       pickImage(); //uploadPic();
              //        print('yes');
              //       // imageFromGallery();
              //       // uploadImage();
              //     },
              //     child: Container(
              //       height: 200,
              //       width: 200,
              //       child: Center(
              //           child: image == null
              //               ? Icon(Icons.person)
              //               : Image.network(image.toString())),
              //     )
              //     // : Container(
              //     //     child: CircleAvatar(
              //     //       backgroundImage: NetworkImage(image.toString()),
              //     //       radius: 70,
              //     //       // ignore: unnecessary_null_comparison
              //     //       // child: _photo == null
              //     //       //     ? Image.asset(
              //     //       //         height: 50,
              //     //       //         'lib/assetsimg/user.png',
              //     //       //       )
              //     //       //     : Image.file(_photo!),
              //     //     ),
              //     //   ),
              //     ),
              ,
              const SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () {
                    print('??????????????$url');
                    uploadPic();
                    // pickImage();
                  },
                  child: Text('UpLoad Image')),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  width: myWidth / 1.5,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill name';
                      }
                    },
                    // onChanged: (value) {
                    //   nameGlobal.currentState!.validate();
                    // },
                    controller: nameController,

                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Student Name',
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: myWidth / 1.5,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill email';
                    }
                  },
                  // onChanged: (value) {
                  //   emailGlobal.currentState!.validate();
                  // },
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill password';
                    }
                  },
                  // onChanged: (value) {
                  //   passwordGlobal.currentState!.validate();
                  // },

                  controller: passwordController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Enter Password',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                  ),
                  onPressed: (() {
                    if(image == null){
                      var snackBar = SnackBar(content: Text('upload your image'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else if (key.currentState!.validate()) {
                      signUpBloc.add(SignUpFetchEvent(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                      image!
                      ));
                    }
                  }),
                  child: const Text('Sign Up')),
              const SizedBox(
                height: 10,
              ),
              const Text('If already have an account?'),
              // TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => const Student(),
              //           ));
              //     },
              //     child: const Text(
              //       'Sign In',
              //     ))
            ],
          ),
      ),
    ),
        ));
  }

  // Future imgFromCamera() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.camera);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _photo = File(pickedFile.path);
  //       uploadImage();
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  // void createUser(String name, String email, String password) async {
  //   if (name == '' || email == '' || password == '') {
  //     print('give all fields');
  //   } else {
  //     try {
  //       Model model = Model();
  //       model.name = name;
  //       model.email = email;
  //       await auth
  //           .createUserWithEmailAndPassword(
  //         email: model.email!,
  //         password: password,
  //       )
  //           .then((value) {
  //         model.uId = auth.currentUser!.uid;
  //       });

  //       String id = const Uuid().v1();
  //       Reference r = storage.ref().child('files/${_photo}');
  //       String url = await r.getDownloadURL();
  //       model.image = url;

  //       fireStore
  //           .collection('User')
  //           .doc(auth.currentUser!.uid)
  //           .collection('UserId')
  //           .doc(id)
  //           .set({
  //         'uId': model.uId,
  //         'name': model.name,
  //         'email': model.email,
  //         'image': model.image
  //       });
  //     } on FirebaseAuthException catch (e) {
  //       print('error : ${e.code.toString()}');
  //     }
  //   }
  // }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Student(),
        BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            if (state is SignUpInitial) {
              return SizedBox();
            } else if (state is SignUpLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SignUpLoadedState) {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const StudentCategery();
                  },
                ));
              });
              return const SizedBox();
            } else if (state is SignUpErrorState) {
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
