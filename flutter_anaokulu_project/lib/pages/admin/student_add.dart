import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/models/student.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/student_db_helper.dart';

class StudentsAddScreen extends StatefulWidget {
  const StudentsAddScreen({Key? key}) : super(key: key);

  @override
  State<StudentsAddScreen> createState() => _StudentsAddScreenState();
}

class _StudentsAddScreenState extends State<StudentsAddScreen> {
  //student info controller
  TextEditingController controllerTC = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSurName = TextEditingController();
  TextEditingController controllerAge = TextEditingController();
  TextEditingController controllerHeight = TextEditingController();
  TextEditingController controllerWeight = TextEditingController();
  TextEditingController controllerBirstDate = TextEditingController();
  TextEditingController controllerAdress = TextEditingController();

  //data base instance
  final dbHelper = DataBaseHelperStudent.instance;

  //image - profil photo
  File? image;

  //kullanacağımız değişken tanımlamaları veriable
  String appbarTitle = "Öğrenci Ekle",
      subtitle =
          "Lütfen Kayit Etmek Istediğiniz Öğrencinin Bİlgilerini Giriniz";

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
            textEditing("Tc", 11, TextInputType.number, controllerTC, "11"),
            textEditing("Ad", 30, TextInputType.text, controllerName, "12"),
            textEditing(
                "Soyad", 15, TextInputType.text, controllerSurName, "13"),
            textEditing("Yaş", 3, TextInputType.number, controllerAge, "14"),
            textEditing("Boy", 3, TextInputType.number, controllerHeight, "15"),
            textEditing(
                "kilo", 3, TextInputType.number, controllerWeight, "16"),
            textEditing("Doğum tarihi", 10, TextInputType.number,
                controllerBirstDate, "17"),
            textEditing(
                "Adres", 100, TextInputType.text, controllerAdress, "18"),
            ElevatedButton(
              key: const Key("19"),
              onPressed: () {
                _imagePickerCamera();
              },
              child: const Text("Kameradan Seç"),
            ),
            ElevatedButton(
              key: const Key("20"),
              onPressed: () {
                _imagePickerGallery();
              },
              child: const Text("Galeriden Seç"),
            ),
            ElevatedButton(
                key: const Key("21"),
                onPressed: () {
                  if (controllerTC.text.isNotEmpty &&
                      controllerName.text.isNotEmpty &&
                      controllerSurName.text.isNotEmpty &&
                      controllerAge.text.isNotEmpty &&
                      controllerHeight.text.isNotEmpty &&
                      controllerWeight.text.isNotEmpty &&
                      controllerBirstDate.text.isNotEmpty &&
                      controllerAdress.text.isNotEmpty) {
                    if (image?.path != null) {
                      _inserStudent();
                    } else {
                      snackBarUse("Lütfen bir resim seçiniz");
                    }
                  } else {
                    snackBarUse("Hiç bir alan boş birakilamaz!");
                  }
                },
                child: const Text("Ekle"))
          ],
        ),
      ),
    );
  }

  Padding textEditing(String label, int maxlength, TextInputType inputType,
      TextEditingController textEditingController, String keys) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        key: Key(keys),
        controller: textEditingController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
        keyboardType: inputType,
        maxLength: maxlength,
      ),
    );
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

  //dataBase tablosunu kayıt etmek için kullanırız
  void _inserStudent() async {
    //eğer sayı girilmesi gereken textfield'e sayıdan başka bir şey girmiş mi diye control etmek için yaptık bu kısmı
    var tc = int.tryParse(controllerTC.text);
    if (tc == null) {
      snackBarUse("Lütfen tc yi bir sayi olarak girin");
    }
    var age = int.tryParse(controllerAge.text);
    if (age == null) {
      snackBarUse("Lütfen yaşini bir sayi olarak girin");
    }
    var height = int.tryParse(controllerHeight.text);
    if (height == null) {
      snackBarUse("Lütfen boyunub bir sayi olarak girin");
    }
    var weight = int.tryParse(controllerWeight.text);
    if (weight == null) {
      snackBarUse("Lütfen kilosunu bir sayi olarak girin");
    }

    if (tc != null && age != null && height != null && weight != null) {
      Map<String, dynamic> row = {
        DataBaseHelperStudent.columnTc: tc,
        DataBaseHelperStudent.columnName: controllerName.text,
        DataBaseHelperStudent.columnSurName: controllerSurName.text,
        DataBaseHelperStudent.columnAge: age,
        DataBaseHelperStudent.columnHeight: height,
        DataBaseHelperStudent.columnWeight: weight,
        DataBaseHelperStudent.columnBirth: controllerBirstDate.text,
        DataBaseHelperStudent.columnAdress: controllerAdress.text,
        DataBaseHelperStudent.columnImagePath: image!.path,
      };
      Student student = Student.fromJson(row);
      final id = await dbHelper.insert(student);
      snackBarUse("id: $id tc: -$tc-");
    }
  }

  //fotograf seçmek için kullanılan func
  void _imagePickerGallery() async {
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (images == null) return;

      final imageTemp = File(images.path); //dart.io unutma
      setState(() {
        image = imageTemp;
      });
      debugPrint("iamge path gallery: " + image!.path.toString());
    } catch (e) {
      debugPrint("Sistemdi Hatanin adi bu: $e !GALLERY!");
    }
  }

  void _imagePickerCamera() async {
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.camera);
      if (images == null) return;

      final imageTemp = File(images.path); //dart.io unutma
      setState(() {
        image = imageTemp;
      });
      debugPrint("iamge path camera: " + image!.path.toString());
    } catch (e) {
      debugPrint("Sistemdi Hatanin adi bu: $e !CAMERA!");
    }
  }
}
