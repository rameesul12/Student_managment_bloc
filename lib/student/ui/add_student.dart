import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_records_bloc/bloc/image_bloc.dart';
import 'package:student_records_bloc/student/bloc/student_bloc.dart';
import '../../model/data_model.dart';

class AddStudentClass extends StatefulWidget {
  const AddStudentClass({Key? key}) : super(key: key);

  @override
  State<AddStudentClass> createState() => _AddStudentClassState();
}
final _formkey=GlobalKey<FormState>();

class _AddStudentClassState extends State<AddStudentClass> {
  final _nameOfStudent = TextEditingController();
  final _ageOfStudent = TextEditingController();
  final _addressOfStudent = TextEditingController();
  final _phnOfStudent = TextEditingController();


  dynamic image;
  bool imageAlert = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                BlocBuilder<ImageBloc, ImageState>(
                  builder: (context, state) {
                    if (state is ImageLoadingState) {
                      return const CircleAvatar(
                        radius: 80,
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ImageLoadedState) {
                      image = state.imageFile;
                      return CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(File(state.imageFile.path)),
                      );
                    } else {
                      return const CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                            'https://png.pngtree.com/png-vector/20220817/ourmid/pngtree-cartoon-man-avatar-vector-ilustration-png-image_6111064.png'),
                      );
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, elevation: 10),
                      onPressed: () {
                        BlocProvider.of<ImageBloc>(context)
                            .add(GetImageEvent());

                        //getPhoto();
                      },
                      icon: const Icon(
                        Icons.image_outlined,
                      ),
                      label: const Text(
                        'Add An Image',
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _nameOfStudent,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter student Name',
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Name';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 2,
                  controller: _ageOfStudent,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter age',
                    labelText: 'age',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Age';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _addressOfStudent,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter address',
                    labelText: 'address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Address';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 10,
                  controller: _phnOfStudent,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the number',
                    labelText: 'number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    } else if (value.length < 10) {
                      return 'invalid phone number';
                    } else {
                      return null;
                    }
                  },
                ),
                ElevatedButton.icon(
                    onPressed: (() {
                      if (_formkey.currentState!.validate() && image != null) {
                        
                     
                        onStudentAddButtonClick(context);
                        BlocProvider.of<ImageBloc>(context)
                            .add(RemoveImageEvent());
                      }
                    }),
                    icon: const Icon(Icons.add),
                    label: const Text('Add student'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onStudentAddButtonClick(BuildContext ctx) async {
    final name = _nameOfStudent.text.trim();
    final age = _ageOfStudent.text.trim();
    final address = _addressOfStudent.text.trim();
    final number = _phnOfStudent.text.trim();

    if (image!.path.isEmpty ||
        name.isEmpty ||
        age.isEmpty ||
        address.isEmpty ||
        number.isEmpty) {
      return showSnakbarMessage();
    }

    BlocProvider.of<StudentBloc>(context).add(StudentAddEvent(
        student: StudentModel(
      name: name,
      age: age,
      phnNumber: number,
      address: address,
      photo: image!.path,
    )));

    Navigator.of(context).pop();
  }

  Future<void> showSnakbarMessage() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        content: Text("Items are Required"),
      ),
    );
  }

  /* File? _photo;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
    } else {
      final photoTemp = File(photo.path);
      setState(
        () {
          _photo = photoTemp;
        },
      );
    }
  } */
}
