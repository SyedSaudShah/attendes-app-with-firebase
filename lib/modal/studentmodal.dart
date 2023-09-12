class StudentModal {
  String uid;
  String name;
  String rollNo;
  bool isCheck;

  StudentModal(
      {required this.uid,
      required this.name,
      required this.rollNo,
      required this.isCheck});

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'name': name, 'roll_no': rollNo, 'ischeck': isCheck};

  static fromJson(Map<String, dynamic> json) => StudentModal(
      uid: json['uid'],
      name: json['name'],
      rollNo: json['roll_No'],
      isCheck: json['isCheck']);
}
