import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/pages/admin/allergy_list_delete.dart';
import 'package:flutter_anaokulu_project/pages/admin/student_delete.dart';
import 'package:flutter_anaokulu_project/pages/admin/student_list.dart';
import 'package:flutter_anaokulu_project/pages/admin/student_lists.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //field
    String appBarTitle = "Yönetici Girişi",
        studentAddScrren = "Öğrenci Ekle",
        studentDeleteScreen = "Öğrenci Sil",
        allergyAddDeleteScreen = "Alerji ekle-sil",
        studentListText = "Öğrenci Listesi";
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              key: const Key("4"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentAllList(),
                    ));
              },
              child: Text(studentAddScrren),
            ),
            ElevatedButton(
              key: const Key("5"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentDelete(),
                    ));
              },
              child: Text(studentDeleteScreen),
            ),
            ElevatedButton(
              key: const Key("6"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllergyAddDel(),
                    ));
              },
              child: Text(allergyAddDeleteScreen),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentList(),
                    ));
              },
              child: Text(studentListText),
            ),
          ],
        ),
      ),
    );
  }
}
