import 'package:hive_flutter/adapters.dart';
import '../model/data_model.dart';

class StudentDatabase {
  static Future<Box<StudentModel>> studentOpenBox() async {
    var box = Hive.openBox<StudentModel>('student_db');
    return box;
  }

  static Future<List<StudentModel>> getAllStudents() async {
    final box = await studentOpenBox();
    List<StudentModel> students = box.values.toList();
    return students;
  }

  static Future<void> addStudent(StudentModel value) async {
    final box = await studentOpenBox();
    value.id = await box.add(value);
  }

  static Future<void> updateStudent(int id, StudentModel value) async {
    final box = await studentOpenBox();
    await box.putAt(id, value);
  }

  static Future<void> deleteStudent(int id) async {
    final box = await studentOpenBox();
    await box.deleteAt(id);
  }
}
