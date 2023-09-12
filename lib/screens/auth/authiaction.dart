// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:attendes/modal/studentmodal.dart';
import 'package:attendes/screens/markattendence.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseStorage fbStorage = FirebaseStorage.instance;

Future<User?> signinWithGoogle() async {
  final GoogleSignInAccount? googleUser =
      await GoogleSignIn(scopes: <String>['Email']).signIn();
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;
  final credendial = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  var user = await FirebaseAuth.instance.signInWithCredential(credendial);
  User? myuser = user.user;
  return myuser;
}

Future<User?> signIn(String email, String password) async {
  UserCredential userCredential =
      await auth.signInWithEmailAndPassword(email: email, password: password);
  User? user = userCredential.user;
  return Future(() => user);
}

Future<User?> signUp(String name, String email, String password,File file) async {
  UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email, password: password);

  User? user = userCredential.user;
  if (user != null) {
    await sendToFirebase(name, email, password, user.uid,file);
  }
  return Future(
    () => user,
  );
}

Future<void> sendToFirebase(
    String name, String email, String password, String uid,File file) async {

  Reference img = fbStorage.ref().child('files/${file.path}');
  await img.putFile(file);

  String url = await img.getDownloadURL();

  await firebaseFirestore.collection('User').doc(uid).set(
      {'User_Name': name, 'Email': email, 'uid': uid, 'image': url});
}

Future creatUser(StudentModal studentModal) async {
  final docUser = await firebaseFirestore.collection('Student').doc();
  studentModal.uid = docUser.id;

  final json = studentModal.toJson();
  await docUser.set(json);
}

Future deleteData(String id) async {
  try {
    await FirebaseFirestore.instance.collection("Student").doc(id).delete();
  } catch (e) {
    return false;
  }
}

Future<void> update(BuildContext context,
    [DocumentSnapshot? documentSnapshot]) async {
  if (documentSnapshot != null) {
    name.text = documentSnapshot['name'];
    rollNo.text = documentSnapshot['roll_no'];
  }

  await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: rollNo,
                decoration: const InputDecoration(
                  labelText: 'RollNo',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Update'),
                onPressed: () async {
                  final String nameStudent = name.text;
                  final String roll = rollNo.text;
                  if (nameStudent != null && roll != null) {
                    await firebaseFirestore
                        .collection('Student')
                        .doc(documentSnapshot!.id)
                        .update({"name": nameStudent, "roll_no": roll});
                    name.text = '';
                    rollNo.text = '';
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        );
      });
}
