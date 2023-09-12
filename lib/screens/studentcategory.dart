import 'package:attendes/screens/auth/view.dart';
import 'package:attendes/screens/markattendence.dart';
import 'package:flutter/material.dart';
;

class StudentCategery extends StatefulWidget {
  const StudentCategery({Key? key}) : super(key: key);

  @override
  State<StudentCategery> createState() => _StudentCategeryState();
}

class _StudentCategeryState extends State<StudentCategery> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return (SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Student Attendence'),
            ),
            body: Center(
              child: SingleChildScrollView(
                  child: Column(children: [
                Container(
                  width: myWidth / 1.5,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Markattendence(),
                            ));
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 14, color: Colors.white))),
                      child: const Text('Attendance')),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: myWidth / 1.5,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  View(),
                            ),
                            (route) => false);
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 14, color: Colors.white))),
                      child: const Text('View')),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: myWidth / 1.5,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 14, color: Colors.white))),
                      child: const Text('Leave')),
                ),
              ])),
            ))));
  }
}
