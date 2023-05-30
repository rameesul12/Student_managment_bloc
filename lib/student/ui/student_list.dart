import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_records_bloc/student/bloc/student_bloc.dart';
import 'display_student.dart';
import 'edit_student.dart';

class ListStudents extends StatelessWidget {
  const ListStudents({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StudentBloc>(context).add(StudentInitialEvent());
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case StudentInitial:
            return Container();

          case StudentLoadingState:
            return ListView.separated(
                itemBuilder: ((context, index) {
                  final data = state.students[index];

                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(
                          File(data.photo),
                        ),
                      ),
                      title: Text(data.name),
                      trailing: Wrap(
                        spacing: 12, // space between two icons
                        children: <Widget>[
                          IconButton(
                            onPressed: (() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((ctx) {
                                    return EditStudent(
                                      studentData: data, index: index,
                                    );
                                  }),
                                ),
                              );
                              // EditStudent();
                            }),
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            tooltip: 'Edit',
                          ),

                          IconButton(
                            onPressed: (() {
                              showDialog(
                                context: context,
                                builder: ((ctx1) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: AlertDialog(
                                      title: const Text(
                                        'Alert!',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      content: const Text(
                                        "Do you want to delete this student",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: (() {
                                            BlocProvider.of<StudentBloc>(
                                                    context)
                                                .add(StudentDeleteEvent(
                                                    id: index));
                                            Navigator.of(context).pop();
                                            //Navigator.of(ctx1).pop();
                                            //popoutfuction(ctx1);
                                            // deleteStudent(index);
                                          }),
                                          child: const Text('Yes'),
                                        ),
                                        TextButton(
                                            onPressed: (() {
                                              popoutfuction(context);
                                            }),
                                            child: const Text('No'))
                                      ],
                                    ),
                                  );
                                }),
                              );
                            }),
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            tooltip: 'Delete',
                          ),
                          // icon-2
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return DisplayStudent(
                               studentDetail: data,
                                index: index,
                              
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  );
                }),
                separatorBuilder: ((context, index) {
                  return const Divider();
                }),
                itemCount: state.students.length);

          default:
            return Text('Error while getting Data');
        }
      },
    );
  }

  popoutfuction(BuildContext context) {
    return Navigator.of(context).pop();
  }
}
