import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_records_bloc/model/data_model.dart';
import 'edit_student.dart';

class DisplayStudent extends StatelessWidget {
  final StudentModel studentDetail;
  final int index;
  const DisplayStudent({
    super.key,
    required this.studentDetail,
    
    required this.index,
  
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Student Full Details',
                    style: TextStyle(fontSize: 25, color: Color(0xFF284350)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(
                    File(
                      studentDetail.photo,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Name: ${studentDetail.name}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Age: ${studentDetail.age}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Address: ${studentDetail.address}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Phone Number: ${studentDetail.phnNumber}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                ElevatedButton.icon(
                    onPressed: (() {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return EditStudent(studentData:studentDetail, index: index,
                          
                        );
                      })));
                    }),
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
