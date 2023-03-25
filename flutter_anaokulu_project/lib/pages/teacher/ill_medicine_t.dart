import 'package:flutter/material.dart';

import '../../models/ill_medicine.dart';
import '../../utils/ill_medicine_db_helper.dart';
import 'ill_medicine_add_t.dart';

class IllMedicineT extends StatefulWidget {
  const IllMedicineT({Key? key}) : super(key: key);

  @override
  State<IllMedicineT> createState() => _IllMedicineTState();
}

class _IllMedicineTState extends State<IllMedicineT> {
  //tüm listeyi çekmek ve işlemek için kullanacağız
  List<IllMedicine> allIllMedicineList = [];

  //field
  String appBarTitle = "Öğrencinin Hastaliklari",
      refreshButton = "Yenile",
      noteAdd = "Not Ekleyiniz",
      studentIll = "Öğrencinin Hastaliği:",
      studentMedicine = "Öğrencinin Kullanmasi gerekn ilaç:",
      teacherNotes = "Öğretmenin notu(tiklayiniz):";

  //showDialog Field
  String okeyButton = "tamam", showDialogTitle = "Öğretmeninizin Notu";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: ListView.builder(
        itemCount: allIllMedicineList.length + 1,
        itemBuilder: (context, index) {
          if (index == allIllMedicineList.length) {
            return ElevatedButton(
                key: const Key("refresh Button ill medicine screen"),
                onPressed: () {
                  _queryAll();
                },
                child: Text(refreshButton));
          }
          return Card(
            child: Column(
              children: [
                Text(
                  studentIll,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(allIllMedicineList[index].ill.toString(),
                    style: const TextStyle(color: Colors.purple, fontSize: 20)),
                Text(
                  studentMedicine,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(allIllMedicineList[index].medicine.toString(),
                    style: const TextStyle(
                        color: Colors.blueAccent, fontSize: 20)),
                ElevatedButton(
                    key: const Key("29"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IllMedicineAddT(
                              illMedicine: IllMedicine(
                                id: allIllMedicineList[index].id,
                                ill: allIllMedicineList[index].ill,
                                medicine: allIllMedicineList[index].medicine,
                                teacherNote:
                                    allIllMedicineList[index].teacherNote,
                              ),
                            ),
                          ));
                    },
                    child: Text(noteAdd))
              ],
            ),
          );
        },
      ),
    );
  }

  void _queryAll() async {
    final allRows = await DataBaseIllMedicineHelper.instance.queryAllRows();
    allIllMedicineList.clear();
    for (var element in allRows) {
      allIllMedicineList.add(IllMedicine.fromJson(element));
    }
    setState(() {});
  }
}
