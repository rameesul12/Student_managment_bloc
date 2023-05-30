import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_records_bloc/bloc/image_bloc.dart';
import 'package:student_records_bloc/model/data_model.dart';
import 'package:student_records_bloc/student/bloc/student_bloc.dart';

class EditStudent extends StatefulWidget {
 final StudentModel studentData;
 final index;

  const EditStudent({
    super.key,
   required this.studentData,required this.index
  });

  @override
  State<EditStudent> createState() => _EditStudentState();
}


class _EditStudentState extends State<EditStudent> {
  TextEditingController _nameOfStudent = TextEditingController();
  TextEditingController _ageOfStudent = TextEditingController();
  TextEditingController _addressOfStudent = TextEditingController();
  TextEditingController _phnOfStudent = TextEditingController();

final _formkey=GlobalKey<FormState>();
  dynamic image;

  @override
  void initState() {
    super.initState();

    _nameOfStudent = TextEditingController(text: widget.studentData.name);
    _ageOfStudent = TextEditingController(text: widget.studentData.age);
    _addressOfStudent = TextEditingController(text: widget.studentData.address);
    _phnOfStudent = TextEditingController(text: widget.studentData.phnNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
              key: _formkey,
              child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const Text(
                  'Edit student details',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<ImageBloc, ImageState>(
                  builder: (context, state) {
                    if (state is ImageLoadingState) {
                      return const CircleAvatar(
                        radius: 70,
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ImageLoadedState) {
                      image = state.imageFile.path;
                      return CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(File(state.imageFile.path)),
                      );
                     } else if (state is ImageErrorState) {
                      return Text(state.errorMessage); 
                    } else {
                      return CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(File(widget.studentData.photo)),
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
                        //getPhoto();
                        // BlocProvider.of<ImageBloc>(context)
                        //     .add(GetImageEvent());
                        context.read<ImageBloc>().add(GetImageEvent());
                      },
                      icon: const Icon(
                        Icons.image_outlined,
                      ),
                      label: const Text(
                        'update An Image',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _nameOfStudent,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '',
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
                    hintText: 'Enter your age',
                    labelText: 'Age',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Age';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _addressOfStudent,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your address',
                    labelText: 'Address',
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
                    hintText: 'Enter your phn',
                    labelText: 'Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Number';
                    } else if (value.length < 10) {
                      return 'invalid phone number';
                    } else {
                      return null;
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                       if(_formkey.currentState!.validate()  && image!=null){
                          onEditSaveButton(widget.index,context);
                       }
                       /*  BlocProvider.of<ImageBloc>(context)
                            .add(RemoveImageEvent()); */
                           
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Future<void> onEditSaveButton(int index,BuildContext ctx) async {
    final eName = _nameOfStudent.text;
    final eAge = _ageOfStudent.text;
    final ephone = _phnOfStudent.text;
    final eAddress = _addressOfStudent.text;
    
    if (eName.isEmpty || eAge.isEmpty || ephone.isEmpty || eAddress.isEmpty) {
      showSnackbarMessage(context);
    } else {
      BlocProvider.of<StudentBloc>(context).add(StudentUpdateEvent(
          name: eName,
          age: eAge,
          phoneNumber: ephone,
          address: eAddress,
          photo: image,
          id: widget.index));
      Navigator.of(context).pop();
    }
  }

  Future<void> showSnackbarMessage(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(30),
        content: Text('Items are Requierd')));
  }
}
