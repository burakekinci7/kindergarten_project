import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/models/ill_medicine.dart';
import 'package:flutter_anaokulu_project/pages/parent/ill_medicine_add.dart';
import 'package:flutter_anaokulu_project/utils/ill_medicine_db_helper.dart';

class IllMedicineScreen extends StatefulWidget {
  const IllMedicineScreen({Key? key}) : super(key: key);

  @override
  State<IllMedicineScreen> createState() => _IllMedicineScreenState();
}

class _IllMedicineScreenState extends State<IllMedicineScreen> {
  //tüm listeyi çekmek ve işlemek için kullanacağız
  List<IllMedicine> allIllMedicineList = [];

  //field
  String appBarTitle = "Öğrencinin Hastaliklari",
      refreshButton = "Yenile",
      illMedicineDelete = "Bu Hastaliği Siliniz",
      studentIll = "Öğrencinin Hastaliği:",
      studentMedicine = "Öğrencinin Kullanmasi gerekn ilaç:",
      teacherNotes = "Öğretmenin notu(tiklayiniz):";

  //showDialog Field
  String okeyButton = "tamam", showDialogTitle = "Öğretmeninizin Notu";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        key: const Key("ill medicine add to Screen"),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const IllMedicineAdd(),
              ));
        },
        child: const Icon(Icons.add),
      ),
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
                    style: const TextStyle(color: Colors.purple, fontSize: 18)),
                Text(
                  studentMedicine,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(allIllMedicineList[index].medicine.toString(),
                    style: const TextStyle(
                        color: Colors.purpleAccent, fontSize: 18)),
                const SizedBox(height: 10),
                GestureDetector(
                  key: const Key("TeacherNote"),
                  child: Text(
                    teacherNotes,
                    style: const TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                  onTap: () {
                    showDialogBox(
                        allIllMedicineList[index].teacherNote.toString());
                  },
                ),
                ElevatedButton(
                    key: const Key("29"),
                    onPressed: () {
                      _deleteIllMedicine(allIllMedicineList[index].id);
                      setState(() {
                        _queryAll();
                      });
                    },
                    child: Text(illMedicineDelete))
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

  void _deleteIllMedicine(int? id) async {
    final delete =
        await DataBaseIllMedicineHelper.instance.deleteIllMedicine(id!);
  }

  void showDialogBox(String teacherNotes) {
    showCupertinoDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(showDialogTitle),
        content: Text(teacherNotes),
        actions: [
          TextButton(
              key: const Key("show Dialog techer Notes"),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(okeyButton))
        ],
      ),
    );
  }
}
