import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/models/ill_medicine.dart';
import 'package:flutter_anaokulu_project/utils/ill_medicine_db_helper.dart';

class IllMedicineAddT extends StatefulWidget {
  const IllMedicineAddT({Key? key, required this.illMedicine})
      : super(key: key);
  final IllMedicine illMedicine;

  @override
  State<IllMedicineAddT> createState() => _IllMedicineAddTState();
}

class _IllMedicineAddTState extends State<IllMedicineAddT> {
  //controller
  TextEditingController illMedicineNotController = TextEditingController();
  //variable
  String appbarTitle = "Not Ekleyiniz", noteAddButton = "Kaydet";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                key: const Key("43"),
                controller: illMedicineNotController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Notunuz",
                ),
              ),
            ),
            ElevatedButton(
              key: const Key("44"),
              onPressed: () {
                _updateIllMedicine(widget.illMedicine);
              },
              child: Text(noteAddButton),
            ),
          ],
        ),
      ),
    );
  }

  void _updateIllMedicine(IllMedicine illMedicineTemp) async {
    IllMedicine illMedicine = IllMedicine(
      id: illMedicineTemp.id,
      ill: illMedicineTemp.ill,
      medicine: illMedicineTemp.medicine,
      teacherNote: illMedicineNotController.text,
    );
    final rowUpdate =
        await DataBaseIllMedicineHelper.instance.updateIllMedicine(illMedicine);
    snackBarUse("Mesajiniz" + illMedicine.teacherNote! + "id: $rowUpdate");
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
