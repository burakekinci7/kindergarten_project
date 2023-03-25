import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/models/allergy.dart';
import 'package:flutter_anaokulu_project/utils/allergy_db_helper.dart';

class AllergyAddT extends StatefulWidget {
  const AllergyAddT({Key? key, required this.allergy}) : super(key: key);

  final Allergy allergy;

  @override
  State<AllergyAddT> createState() => _AllergyAddTState();
}

class _AllergyAddTState extends State<AllergyAddT> {
  //controller
  TextEditingController allergyController = TextEditingController();
  //veriable
  String appBarTitle = "Alerji Notu Ekle";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Eski Notunuz:  " + widget.allergy.teacherNote!,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                key: const Key("40"),
                controller: allergyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Alerji",
                ),
              ),
            ),
            ElevatedButton(
              key: const Key("41"),
              onPressed: () {
                _teacherNoteUpdate(
                    widget.allergy.id!,
                    widget.allergy.allergyName!,
                    allergyController.text,
                    widget.allergy.state!);
                snackBarUse("Not Eklendi: " + allergyController.text);
              },
              child: const Text("kaydet"),
            ),
          ],
        ),
      ),
    );
  }

  void _teacherNoteUpdate(
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
    final rowUpdate = await DataBaseAllergy.instance.updateAllergy(allergy);
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
