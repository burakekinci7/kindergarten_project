import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/pages/teacher/student_info_t.dart';

import '../../models/student.dart';
import '../../utils/student_db_helper.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({Key? key}) : super(key: key);

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  //all student list
  List<Student> allStudent = [];

  //attribute
  String student = "Öğrenci Hakkinda",
      appbarTitle = "Öğretmen Girişi",
      refreshButton = "Yenile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle),
      ),
      body: ListView.builder(
        itemCount: allStudent.length + 1,
        itemBuilder: (context, index) {
          if (index == allStudent.length) {
            return ElevatedButton(
                key: const Key("9"),
                onPressed: () {
                  setState(() {
                    _queryAll();
                  });
                },
                child: Text(refreshButton));
          }
          return Card(
            child: Expanded(
              child: Row(
                children: [
                  SizedBox(
                    height: 200,
                    width: 150,
                    child: Image.file(
                      File(allStudent[index].imagePath!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          /*  Text(
                            "Öğrencinin ID: " + allStudent[index].id.toString(),
                          ), */
                          Text(
                            "Öğrencinin Adi: " +
                                allStudent[index].name.toString(),
                          ),
                          Text(
                            "Öğrencinin Soyadi: " +
                                allStudent[index].surname.toString(),
                          ),
                          Text(
                            "Öğrencinin Yaşi: " +
                                allStudent[index].age.toString(),
                          ),
                          Text(
                            "Doğum Tarihi: " +
                                allStudent[index].birth.toString(),
                          ),
                          Text(
                            "Boy Uzunluğu: " +
                                allStudent[index].height.toString() +
                                " cm",
                          ),
                          Text(
                            "Ev adresi: " + allStudent[index].adress.toString(),
                          ),
                          Text(
                            "Kilosu: " +
                                allStudent[index].weight.toString() +
                                " kg",
                          ),
                          Text(
                            "TC : " + allStudent[index].tc.toString(),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StudentListT(
                                          id: allStudent[index].id!),
                                    ));
                              },
                              child: Text(student))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //tüm tabloyu sıralamak icin kullanilir
  void _queryAll() async {
    final allRows = await DataBaseHelperStudent.instance.queryAllRows();
    allStudent.clear();
    for (var element in allRows) {
      allStudent.add(Student.fromJson(element));
    }
    setState(() {});
  }
}
