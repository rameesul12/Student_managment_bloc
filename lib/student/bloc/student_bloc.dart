import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_records_bloc/data/db_functions.dart';
import 'package:student_records_bloc/model/data_model.dart';
part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  List<StudentModel> studentData = [];
  StudentBloc() : super(StudentInitial()) {
    on<StudentInitialEvent>(
      (event, emit) async {
        emit(StudentLoadingState(studentData));
        await _getStudents();
        emit(StudentLoadingState(studentData));
      },
    );
    on<StudentAddEvent>(studentAddEvent);
    on<StudentUpdateEvent>(studentUpdateEvent);
    on<StudentDeleteEvent>(studentDeleteEvent);
  }

  Future<void> _getStudents() async {
    await StudentDatabase.getAllStudents().then((value) {
      studentData = value;
    });
  }

  FutureOr<void> studentAddEvent(
      StudentAddEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoadingState(studentData));
    await StudentDatabase.addStudent(event.student);
    await _getStudents();
    emit(StudentLoadingState(studentData));
  }

  FutureOr<void> studentUpdateEvent(
      StudentUpdateEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoadingState(studentData));
    await _updateStudent(
        name: event.name,
        id: event.id,
        age: event.age,
        phoneNumber: event.phoneNumber,
        address: event.address,
        photo: event.photo);
    await _getStudents();
    emit(StudentLoadingState(studentData));
  }

  FutureOr<void> studentDeleteEvent(
      StudentDeleteEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoadingState(studentData));
    await _removeFromList(id: event.id);
    await _getStudents();
    emit(StudentLoadingState(studentData));
  }

  Future<void> _updateStudent(
      {required String name,
      required int id,
      required String age,
      required String phoneNumber,
      required String address,
      required String photo}) async {
    await StudentDatabase.updateStudent(
        id,
        StudentModel(
            name: name,
            age: age,
            phnNumber: phoneNumber,
            address: address,
            photo: photo));
  }

  Future<void> _removeFromList({required id}) async {
    await StudentDatabase.deleteStudent(id);
    await _getStudents();
  }
}
