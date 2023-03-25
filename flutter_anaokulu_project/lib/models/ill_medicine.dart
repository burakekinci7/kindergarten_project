import '../utils/ill_medicine_db_helper.dart';

class IllMedicine {
  int? id;
  String? ill;
  String? medicine;
  String? teacherNote;

  IllMedicine({this.id, this.ill, this.medicine, this.teacherNote});

  IllMedicine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ill = json['ill'];
    medicine = json['medicine'];
    teacherNote = json['note'];
  }

  Map<String, dynamic> toJMap() {
    return {
      DataBaseIllMedicineHelper.columnId: id,
      DataBaseIllMedicineHelper.columnIll: ill,
      DataBaseIllMedicineHelper.columnMedicine: medicine,
      DataBaseIllMedicineHelper.columnTeacherNote: teacherNote,
    };
  }
}
