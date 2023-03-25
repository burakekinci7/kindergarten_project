import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentInfo extends StatefulWidget {
  const StudentInfo({Key? key}) : super(key: key);

  @override
  State<StudentInfo> createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Öğrenci Hakkında"),
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
          const Text("Boy:" "153cm"),
          const Text("Kilo:" "45 kg"),
          const Text("Doğum Tarihi:" "10.10.2000"),
          const Text("Adres:" "Ataşehir İstanbul"),
          ElevatedButton(
              key: const Key("28"),
              onPressed: () {
                _makePhoneCall("+905555555555");
              },
              child: const Text("Öğretmenini Ara"))
        ],
      ),
    );
  }

  //call with phone number
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
