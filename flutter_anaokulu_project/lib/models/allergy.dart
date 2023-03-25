import 'package:flutter_anaokulu_project/utils/allergy_db_helper.dart';

class Allergy {
  int? id;
  String? allergyName;
  int? state;
  String? teacherNote;

  Allergy({
    this.id,
    this.allergyName,
    this.state,
    this.teacherNote,
  });

  Allergy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    allergyName = json['allergyName'];
    state = json['state'];
    teacherNote = json['teacherNote'];
  }

  Map<String, dynamic> toJson() {
    return {
      DataBaseAllergy.columnId: id,
      DataBaseAllergy.columnAllergy: allergyName,
      DataBaseAllergy.columnState: state,
      DataBaseAllergy.columnTeacherNote: teacherNote,
    };
  }
}
