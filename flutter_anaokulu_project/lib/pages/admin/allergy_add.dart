import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/models/allergy.dart';
import 'package:flutter_anaokulu_project/utils/allergy_db_helper.dart';

class AlergyAddScreen extends StatefulWidget {
  const AlergyAddScreen({Key? key}) : super(key: key);

  @override
  State<AlergyAddScreen> createState() => _AlergyAddScreenState();
}

class _AlergyAddScreenState extends State<AlergyAddScreen> {
  //controller
  TextEditingController allergyAddController = TextEditingController();
  //field
  String appbarTitle = "Alerji Ekleme",
      allergyAddButton = "Alerjiyi Ekle",
      subtitle = "Lütfen Eklemek Istediğiniz Alerjiyi Giriniz";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appbarTitle)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                subtitle,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                key: const Key("22"),
                controller: allergyAddController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Alerji ",
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            ElevatedButton(
                key: const Key("23"),
                onPressed: () {
                  if (allergyAddController.text.isNotEmpty) {
                    _insertAllergy();
                  } else {
                    snackBarUse("Lütfen bir alerji giriniz");
                  }
                },
                child: Text(allergyAddButton))
          ],
        ),
      ),
    );
  }

  void _insertAllergy() async {
    Map<String, dynamic> rowAllergy = {
      DataBaseAllergy.columnAllergy: allergyAddController.text,
      DataBaseAllergy.columnState: 0,
      DataBaseAllergy.columnTeacherNote: "Herhangi bir açiklma yok",
    };
    Allergy allergy = Allergy.fromJson(rowAllergy);
    final id = await DataBaseAllergy.instance.insertAllergy(allergy);
    snackBarUse("allergy id:$id - alerji ismi:${allergy.allergyName}");
  }

  snackBarUse(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: (Colors.black12),
      action: SnackBarAction(
        label: 'Tamam',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
