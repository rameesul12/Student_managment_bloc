import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records_bloc/bloc/image_bloc.dart';
import 'package:student_records_bloc/student/bloc/student_bloc.dart';
import 'home_screen.dart';
import 'model/data_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(BlocProvider(
    create: (context) => StudentBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StudentBloc>(context).add(StudentInitialEvent());

    return MultiBlocProvider(
        providers: [
          BlocProvider<ImageBloc>(
            create: (context) => ImageBloc(),
          ),
          BlocProvider<StudentBloc>(
            create: (context) => StudentBloc(),)
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(body: HomeScreen()),
        ));
  }
}
