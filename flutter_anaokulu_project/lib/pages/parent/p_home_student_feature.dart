import 'package:flutter/material.dart';
import 'package:flutter_anaokulu_project/pages/parent/allergy_screen.dart';
import 'package:flutter_anaokulu_project/pages/parent/ill_medicine.dart';

import 'student_info.dart';

class StudentFeature extends StatefulWidget {
  const StudentFeature({Key? key}) : super(key: key);

  @override
  State<StudentFeature> createState() => _StudentFeatureState();
}

class _StudentFeatureState extends State<StudentFeature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Veli Girişi"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(height: 100, width: 100, color: Colors.red),
              const Text("Ramazan Burak Ekinci\nyaş:20")
            ],
          ),
          const Divider(),
          ElevatedButton(
            key: const Key("25"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentInfo(),
                  ));
            },
            child: const Text("Öğrenci Hakkında"),
          ),
          ElevatedButton(
            key: const Key("26"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IllMedicineScreen(),
                  ));
            },
            child: const Text("Hastalık-İlaç"),
          ),
          ElevatedButton(
            key: const Key("27"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllergyScreen(),
                  ));
            },
            child: const Text("Alerji"),
          ),
        ],
      ),
    );
  }
}
