import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/models/student.dart';
import 'package:flutter_anaokulu_project/pages/teacher/ill_medicine_t.dart';
import 'package:flutter_anaokulu_project/utils/student_db_helper.dart';

import 'allergy_screen_t.dart';

class StudentListT extends StatefulWidget {
  const StudentListT({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<StudentListT> createState() => _StudentListTState();
}

class _StudentListTState extends State<StudentListT> {
  //all student list
  List<Student> allStudent = [];

  //attribute
  String appBarTitle = "Öğrenci Hakkinda",
      allrgyButton = "Alerjileri",
      illButton = "Hastaliklari",
      refreshButton = "Yenile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
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
          if (allStudent[index].id == widget.id) {
            return Card(
              child: Row(
                children: [
                  Expanded(
                    flex: 40,
                    child: SizedBox(
                      height: 220,
                      width: 100,
                      child: Image.file(
                        File(allStudent[index].imagePath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Text(
                            "Öğrencinin adi: " +
                                allStudent[index].name.toString(),
                          ),
                          Text(
                            "Öğrencinin Soyadi: " +
                                allStudent[index].surname.toString(),
                          ),
                          Text(
                            "Öğrencinin yaşi: " +
                                allStudent[index].age.toString(),
                          ),
                          Text(
                            "Doğum Tarihi: " +
                                allStudent[index].birth.toString(),
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
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AllergyScreenT(),
                                    ));
                              },
                              child: Text(allrgyButton)),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const IllMedicineT(),
                                    ));
                              },
                              child: Text(illButton)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Card();
        },
      ),
    );
  }

  void _queryAll() async {
    final allRows = await DataBaseHelperStudent.instance.queryAllRows();
    allStudent.clear();
    for (var element in allRows) {
      allStudent.add(Student.fromJson(element));
    }
    setState(() {});
  }
}
