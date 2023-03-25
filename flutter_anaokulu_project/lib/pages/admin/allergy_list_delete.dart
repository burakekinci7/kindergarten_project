import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/models/allergy.dart';
import 'package:flutter_anaokulu_project/utils/allergy_db_helper.dart';

import 'allergy_add.dart';

class AllergyAddDel extends StatefulWidget {
  const AllergyAddDel({Key? key}) : super(key: key);

  @override
  State<AllergyAddDel> createState() => _AllergyAddDelState();
}

class _AllergyAddDelState extends State<AllergyAddDel> {
  //tüm alerjileri listeleme
  List<Allergy> allAllergyList = [];

  //field
  String refreshButtonName = "Sayfayi Yenile",
      appbarTitle = "Alerji Listesi ve Silme işlemi",
      allergyAddId = "Eklenilen Alerji numarasi: ";

  TextEditingController allergyDeleteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle),
        actions: [
          IconButton(
              key: const Key("24"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AlergyAddScreen(),
                    ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: allAllergyList.length + 1,
        padding:
            const EdgeInsets.only(bottom: 20, left: 10, right: 10, top: 10),
        itemBuilder: (context, index) {
          if (allAllergyList.length == index) {
            return ElevatedButton(
              key: const Key("25"),
              onPressed: () {
                _quertAllRowsAllergy();
              },
              child: Text(refreshButtonName),
            );
          }
          return Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      allergyAddId,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    Text(allAllergyList[index].id.toString()),
                  ],
                ),
                Text(allAllergyList[index].allergyName.toString(),
                    style: const TextStyle(fontSize: 25)),
                ElevatedButton(
                    onPressed: () {
                      _delete(allAllergyList[index].id!);
                      _quertAllRowsAllergy();
                    },
                    child: const Text("Siliniz"))
              ],
            ),
          );
        },
      ),
    );
  }

  void _delete(int id) async {
    await DataBaseAllergy.instance.delete(id);
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
