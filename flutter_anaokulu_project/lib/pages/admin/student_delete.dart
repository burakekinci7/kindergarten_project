import 'package:flutter/material.dart';

import '../../utils/student_db_helper.dart';

class StudentDelete extends StatefulWidget {
  const StudentDelete({Key? key}) : super(key: key);

  @override
  State<StudentDelete> createState() => _StudentDeleteState();
}

class _StudentDeleteState extends State<StudentDelete> {
  //controller
  TextEditingController tcDeleteController = TextEditingController();
  //variable
  String appbarTitle = "Öğrenci Sil",
      subtitle = "Lütfen Silmek Istediğiniz Öğrencinin TC Girininz";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appbarTitle)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(subtitle),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                key: const Key("7"),
                controller: tcDeleteController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "TC",
                ),
                keyboardType: TextInputType.number,
                maxLength: 11,
              ),
            ),
            ElevatedButton(
                key: const Key("8"),
                onPressed: () {
                  var inrTc = int.tryParse(tcDeleteController.text);
                  if (inrTc != null) {
                    int deleteId = int.parse(tcDeleteController.text);
                    if (tcDeleteController.text.length == 11) {
                      _delete(deleteId);
                    } else {
                      snackBarUse("Lütfen geçerli ve 11 haneli tc giriniz");
                    }
                  } else {
                    snackBarUse("Lütfen TC kimlik numarasini girinz!");
                  }
                },
                child: const Text("Sil"))
          ],
        ),
      ),
    );
  }

  //student i silmek için kullanılan delete func
  void _delete(int deleteId) async {
    final delete = await DataBaseHelperStudent.instance.delete(deleteId);
    snackBarUse("Silinen $delete, kullanici tc: $deleteId");
  }

  //tab bildirimi snackbar
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
