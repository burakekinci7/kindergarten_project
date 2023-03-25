import 'package:flutter_anaokulu_project/utils/student_db_helper.dart';

class Student {
  int? id;
  int? tc;
  String? name;
  String? surname;
  int? age;
  int? height;
  int? weight;
  String? birth;
  String? adress;
  String? imagePath;

  Student({
    this.id,
    this.tc,
    this.name,
    this.surname,
    this.age,
    this.height,
    this.weight,
    this.birth,
    this.adress,
    this.imagePath,
  });

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tc = json['tc'];
    name = json['name'];
    surname = json['surname'];
    age = json['age'];
    height = json['height'];
    weight = json['weight'];
    birth = json['birth'];
    adress = json['adress'];
    imagePath = json['imagepath'];
  }

  Map<String, dynamic> toJson() {
    return {
      DataBaseHelperStudent.columnId: id,
      DataBaseHelperStudent.columnTc: tc,
      DataBaseHelperStudent.columnName: name,
      DataBaseHelperStudent.columnSurName: surname,
      DataBaseHelperStudent.columnAge: age,
      DataBaseHelperStudent.columnHeight: height,
      DataBaseHelperStudent.columnWeight: weight,
      DataBaseHelperStudent.columnBirth: birth,
      DataBaseHelperStudent.columnAdress: adress,
      DataBaseHelperStudent.columnImagePath: imagePath,
    };
  }
}
