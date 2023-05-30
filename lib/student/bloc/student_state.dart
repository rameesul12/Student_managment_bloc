part of 'student_bloc.dart';

//@immutable
abstract class StudentState {
  List<StudentModel> students = [];
  StudentState({required this.students});
}

//Initial
class StudentInitial extends StudentState {
  StudentInitial() : super(students: []);
}

//Loading
class StudentLoadingState extends StudentState {
  StudentLoadingState(List<StudentModel> studentList)
      : super(students: studentList);
}

//Edit
class StudentStateUpdate extends StudentState {
  final List<StudentModel> students;

  StudentStateUpdate({required this.students}) : super(students: students);
}
