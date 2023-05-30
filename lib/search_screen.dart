import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_records_bloc/student/bloc/student_bloc.dart';
import 'package:student_records_bloc/student/ui/display_student.dart';
import 'package:student_records_bloc/student/ui/student_list.dart';

class SearchWidget extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // for closing the search page and going back
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
      if (state is StudentLoadingState) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = state.students[index];
            if (data.name.toLowerCase().contains(query.toLowerCase())) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) {
                            return const ListStudents();
                          }),
                        ),
                      );
                    },
                    title: Text(data.name),
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(data.photo)),
                    ),
                  ),
                  const Divider()
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: state.students.length,
        );
      } else {
        return Container();
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
      if (state is StudentLoadingState) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = state.students[index];
            if (data.name.toLowerCase().contains(query.toLowerCase())) {
              //if (data.name.contains(query)) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
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
                    title: Text(data.name),
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(data.photo)),
                    ),
                  ),
                  const Divider()
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: state.students.length,
        );
      }
      return Container();
    });
  }
}
