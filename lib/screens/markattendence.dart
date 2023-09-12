import 'package:attendes/modal/checkConnection.dart';
import 'package:attendes/modal/studentmodal.dart';
import 'package:attendes/screens/auth/authiaction.dart';
import 'package:flutter/material.dart';

final TextEditingController name = TextEditingController();
final TextEditingController rollNo = TextEditingController();

class Markattendence extends StatefulWidget {
  const Markattendence({super.key});

  @override
  State<Markattendence> createState() => _MarkattendenceState();
}

class _MarkattendenceState extends State<Markattendence> {
  String? attendence = 'absent';

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: myWidth / 1.5,
              child: TextField(
                controller: name,
                maxLength: 10,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Student Name',
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: myWidth / 1.5,
              child: TextField(
                controller: rollNo,
                maxLength: 10,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Roll No',
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: myHeight / 15,
                ),
                const Text('Mark Attendence'),
                RadioListTile(
                  title: const Text("Absent"),
                  value: "absent",
                  groupValue: attendence,
                  onChanged: (value) {
                    setState(() {
                      attendence = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text("Present"),
                  value: "present",
                  groupValue: attendence,
                  onChanged: (value) {
                    setState(() {
                      attendence = value.toString();
                    });
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: myHeight / 20),
              width: myWidth / 1.5,
              child: ElevatedButton(
                onPressed: () async{
                 bool check = await CheckConnection.checkInternet(context);
                 if(check){
                   String namestudent = name.text;
                   String roll = rollNo.text;
                   name.clear();
                   rollNo.clear();
                   if(namestudent == ''){
                     var snackBar = SnackBar(content: Text('please give name'));
                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                   }else if(rollNo == ''){
                     var snackBar = SnackBar(content: Text('please give rollNo'));
                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                   }else{
                     if(attendence == 'present'){
                       final user = StudentModal(
                           uid: '', name: namestudent, rollNo: roll, isCheck: true);

                       creatUser(user);
                     }else{
                       final user = StudentModal(
                           uid: '', name: namestudent, rollNo: roll, isCheck: false);

                       creatUser(user);
                     }
                   }
                 }else{
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Connection Error')));
                 }
                },
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
