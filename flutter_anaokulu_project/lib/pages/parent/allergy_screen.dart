import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/models/allergy.dart';

import '../../utils/allergy_db_helper.dart';
import 'allergy_add.dart';

class AllergyScreen extends StatefulWidget {
  const AllergyScreen({Key? key}) : super(key: key);

  @override
  State<AllergyScreen> createState() => _AllergyScreenState();
}

class _AllergyScreenState extends State<AllergyScreen> {
  //tüm alerjileri listeleme
  List<Allergy> allAllergyList = [];

  //field
  String appbarTitle = "Öğrencinin Alerjileri", refreshButton = "Yenile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        key: const Key("37"),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AllergyAdd(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: Text(appbarTitle)),
      body: ListView.builder(
        itemCount: allAllergyList.length + 1,
        itemBuilder: (context, index) {
          if (allAllergyList.length == index) {
            return ElevatedButton(
              key: const Key("36"),
              onPressed: () {
                _quertAllRowsAllergy();
              },
              child: Text(refreshButton),
            );
          }
          if (allAllergyList[index].state == 1) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                shadowColor: Colors.pink,
                child: Column(
                  children: [
                    const Text(
                      "Öğrencinin alerjisi:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    Text(
                      allAllergyList[index].allergyName.toString(),
                      style:
                          const TextStyle(fontSize: 18, color: Colors.blueGrey),
                    ),
                    GestureDetector(
                      child: const Text(
                        "Öğretmenin Notu(Tiklayiniz)",
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                      key: const Key("35"),
                      onTap: () {
                        showDialogBox(
                            allAllergyList[index].teacherNote.toString());
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _quertAllRowsAllergy() async {
    final all = await DataBaseAllergy.instance.queryAllRowsAllergy();
    allAllergyList.clear();
    for (var item in all) {
      allAllergyList.add(Allergy.fromJson(item));
    }
    setState(() {});
  }

  void showDialogBox(String teacherNotes) {
    showCupertinoDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Öğretmenin Notu"),
        content: Text(teacherNotes),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tamam"))
        ],
      ),
    );
  }
}
