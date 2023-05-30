import 'package:flutter/material.dart';
import 'package:student_records_bloc/search_screen.dart';
import 'package:student_records_bloc/student/bloc/student_bloc.dart';
import 'package:student_records_bloc/student/ui/add_student.dart';
import 'package:student_records_bloc/student/ui/student_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StudentBloc studentBloc = StudentBloc();

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    //getallstudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchWidget(),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: const ListStudents(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddStudentClass();
              },
            ),
          );
        },
        tooltip: 'Add students',
        child: const Icon(Icons.add),
      ),
    );
  }
}
