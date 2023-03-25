import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/models/ill_medicine.dart';
import 'package:flutter_anaokulu_project/utils/ill_medicine_db_helper.dart';

class IllMedicineAdd extends StatefulWidget {
  const IllMedicineAdd({Key? key}) : super(key: key);

  @override
  State<IllMedicineAdd> createState() => _IllMedicineAddState();
}

class _IllMedicineAddState extends State<IllMedicineAdd> {
  TextEditingController illNotController = TextEditingController();
  TextEditingController medicineNotController = TextEditingController();
  TextEditingController teacherNotController = TextEditingController();
  String tempTeacherNote = "Açiklama yada blgilendirme eklenmemiş",
      appBarTitle = "Hastalik Ekleme",
      illNote = "Öğrencinin Hastaliği",
      medicineNote = "Kullanilan İlaç",
      saveButton = "Hastaliği Kaydet",
      snakBarFull = "Lütfen boş alan birakmadiğinizdan emin olunuz ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                key: const Key("30"),
                controller: illNotController,
                maxLines: 10,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: illNote,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                key: const Key("31"),
                controller: medicineNotController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: medicineNote,
                ),
              ),
            ),
            ElevatedButton(
              key: const Key("32"),
              onPressed: () {
                if (illNotController.text.isNotEmpty &&
                    medicineNotController.text.isNotEmpty) {
                  _insertillMedicine();
                } else {
                  snackBarUse(snakBarFull);
                }
              },
              child: Text(saveButton),
            ),
            //deneme için eklendi silinmesi lazım
            /* Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: teacherNotController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "öğretmen notu",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (teacherNotController.text.isNotEmpty) {
                  _updateteacherNotes();
                } else {
                  snackBarUse("Lütfen Doldurnuz");
                }
              },
              child: const Text("kaydet"),
            ), */
            //bu ara sılinicek
          ],
        ),
      ),
    );
  }

  _insertillMedicine() async {
    Map<String, dynamic> row = {
      DataBaseIllMedicineHelper.columnIll: illNotController.text,
      DataBaseIllMedicineHelper.columnMedicine: medicineNotController.text,
      DataBaseIllMedicineHelper.columnTeacherNote: tempTeacherNote,
    };
    IllMedicine illMedicine = IllMedicine.fromJson(row);
    final id =
        await DataBaseIllMedicineHelper.instance.insertIllMed(illMedicine);
    snackBarUse("id: $id }");
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

  /* void _updateteacherNotes() async {
    IllMedicine illMedicine = IllMedicine(
        id: 4, ill: "değişti", medicine: "değişti", teacherNote: "değişti");
    final rowUpdate =
        await DataBaseIllMedicineHelper.instance.updateIllMedicine(illMedicine);
  } */
}
