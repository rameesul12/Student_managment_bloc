part of 'student_bloc.dart';

@immutable
abstract class StudentEvent {}

class StudentInitialEvent extends StudentEvent {}

class StudentAddEvent extends StudentEvent {
  final StudentModel student;
  StudentAddEvent({required this.student});
}

class StudentUpdateEvent extends StudentEvent {
  final String name, age, phoneNumber, address, photo;
  final int id;

  StudentUpdateEvent(
      {required this.name,
      required this.age,
      required this.phoneNumber,
      required this.address,
      required this.photo,
      required this.id});
}

class StudentDeleteEvent extends StudentEvent {
  final int id;

  StudentDeleteEvent({required this.id});
}
