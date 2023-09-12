import 'package:attendes/modal/studentmodal.dart';
import 'package:attendes/screens/auth/authiaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class View extends StatefulWidget {
  const View({super.key});

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  final CollectionReference user =
      FirebaseFirestore.instance.collection('Student');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text('Student Data')),
      body: StreamBuilder(
        stream: user.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: Card(
                    elevation: 1,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['name']),
                      subtitle: Text(documentSnapshot['roll_no'].toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    update(context, documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    deleteData(documentSnapshot.id)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}

Widget buildUser(StudentModal studentModal) {
  return ListTile(
    leading: const CircleAvatar(
      child: Icon(Icons.person),
    ),
    title: Text(studentModal.name),
    subtitle: Text(studentModal.rollNo),
    trailing: SizedBox(
      width: 100,
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                deleteData(studentModal.uid);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
    ),
  );
}
