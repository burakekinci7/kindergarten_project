import 'package:flutter/material.dart';

import '../../models/allergy.dart';
import '../../utils/allergy_db_helper.dart';
import 'allergy_add_t.dart';

class AllergyScreenT extends StatefulWidget {
  const AllergyScreenT({Key? key}) : super(key: key);

  @override
  State<AllergyScreenT> createState() => _AllergyScreenTState();
}

class _AllergyScreenTState extends State<AllergyScreenT> {
  //tüm alerjileri listeleme
  List<Allergy> allAllergyList = [];

  //field
  String appbarTitle = "Öğrencinin Alerjileri",
      refreshButton = "Yenile",
      studentAllergy = "Öğrencinin alerjisi:",
      clickNoteAdd = "Not Ekleyebilirsiniz (Tiklayiniz)";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Text(
                      studentAllergy,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    Text(
                      allAllergyList[index].allergyName.toString(),
                      style:
                          const TextStyle(fontSize: 20, color: Colors.purple),
                    ),
                    GestureDetector(
                      child: Text(
                        clickNoteAdd,
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                      key: const Key("35"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllergyAddT(
                                  allergy: Allergy(
                                allergyName: allAllergyList[index].allergyName,
                                id: allAllergyList[index].id,
                                state: allAllergyList[index].state,
                                teacherNote: allAllergyList[index].teacherNote,
                              )),
                            ));
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
}
