import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/models/allergy.dart';
import 'package:flutter_anaokulu_project/utils/allergy_db_helper.dart';

class AllergyAdd extends StatefulWidget {
  const AllergyAdd({Key? key}) : super(key: key);

  @override
  State<AllergyAdd> createState() => _AllergyAddState();
}

class _AllergyAddState extends State<AllergyAdd> {
  //tüm alerjileri listeleme
  List<Allergy> allAllergyList = [];

  //controller
  TextEditingController allergyController = TextEditingController();

  //dataBase
  final _dbHelper = DataBaseAllergy.instance;

  //field
  String appBatTitle = "Tüm Alerjiler",
      refershButton = "Yenile",
      allergyAdd = "Alerji Ekleyiniz",
      allergyEject = "Alerjiyi Çikar";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(appBatTitle)),
        body: ListView.builder(
          itemCount: allAllergyList.length + 1,
          itemBuilder: (context, index) {
            if (allAllergyList.length == index) {
              return ElevatedButton(
                  key: const Key("38"),
                  onPressed: () {
                    setState(() {
                      _quertAllRowsAllergy();
                    });
                  },
                  child: Text(refershButton));
            }
            return Card(
              child: Column(
                children: [
                  Text(
                    allAllergyList[index].allergyName.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  allAllergyList[index].state == 0
                      ? const Text(
                          "Alerji Eklenmedi",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        )
                      : const Text(
                          "Alerji Eklendi",
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                  ElevatedButton(
                      key: const Key("39"),
                      onPressed: () {
                        _stateUpdate(
                          allAllergyList[index].id!,
                          allAllergyList[index].allergyName!,
                          allAllergyList[index].teacherNote!,
                          allAllergyList[index].state == 0 ? 1 : 0,
                        );
                        setState(() {
                          _quertAllRowsAllergy();
                        });
                      },
                      child: allAllergyList[index].state == 0
                          ? Text(allergyAdd)
                          : Text(allergyEject))
                ],
              ),
            );
          },
        ));
  }

  void _quertAllRowsAllergy() async {
    final all = await _dbHelper.queryAllRowsAllergy();
    allAllergyList.clear();
    for (var item in all) {
      allAllergyList.add(Allergy.fromJson(item));
    }
    setState(() {});
  }

  void _stateUpdate(
    int id,
    String allergys,
    String teacherNotes,
    int state1,
  ) async {
    Allergy allergy = Allergy(
        id: id,
        state: state1,
        teacherNote: teacherNotes,
        allergyName: allergys);
    final rowUpdate = await _dbHelper.updateAllergy(allergy);
  }
}
