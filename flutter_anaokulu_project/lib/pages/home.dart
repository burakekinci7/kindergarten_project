import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/pages/admin/admin.dart';
import 'package:flutter_anaokulu_project/pages/parent/p_home_student_feature.dart';
import 'package:flutter_anaokulu_project/pages/teacher/teacher_home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //field
  String appBArTitleHome = "Lütfen size uygun olani seçiniz",
      adminSignInButton = "Yönetici Girişi",
      parentSignInButton = "Veli Girili",
      teacherSignInButton = "Öğretmen Girişi";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBArTitleHome),
        centerTitle: true,
        actions: const [Icon(Icons.flash_on)],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminScreen(),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.home),
                    const SizedBox(width: 10),
                    Text(adminSignInButton),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeacherHome(),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.school),
                    const SizedBox(width: 10),
                    Text(teacherSignInButton),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudentFeature(),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.people),
                    const SizedBox(width: 10),
                    Text(parentSignInButton),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
