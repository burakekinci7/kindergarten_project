import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/pages/admin/student_add.dart';

import '../../models/student.dart';
import '../../utils/student_db_helper.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  //all student list
  List<Student> allStudent = [];

  //field
  String studentListTitle = "Tüm öğrencilerin Listesi";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(studentListTitle),
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
                child: const Text("Yenile"));
          }
          return Card(
            child: Row(
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.file(
                    File(allStudent[index].imagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text(
                        "Öğrencinin adi: " + allStudent[index].name.toString(),
                      ),
                      Text(
                        "Öğrencinin Soyadi: " +
                            allStudent[index].surname.toString(),
                      ),
                      Text(
                        "Öğrencinin yaşi: " + allStudent[index].age.toString(),
                      ),
                      Text(
                        "Doğum Tarihi: " + allStudent[index].birth.toString(),
                      ),
                      Text(
                        "Boyu: " + allStudent[index].height.toString(),
                      ),
                      Text(
                        "Ev adresi: " + allStudent[index].adress.toString(),
                      ),
                      Text(
                        "Kilosu: " + allStudent[index].weight.toString(),
                      ),
                      Text(
                        "TC : " + allStudent[index].tc.toString(),
                      ),
                    ],
                  ),
                ),
              ],
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
