import 'package:al_hidayah/features/overview/bloc/overview_bloc.dart';
import 'package:al_hidayah/features/overview/ui/student_overview/student_create.dart';
import 'package:al_hidayah/features/overview/ui/student_overview/student_detailview.dart';
import 'package:al_hidayah/models/students.dart';
import 'package:al_hidayah/widgets/App_Bar.dart';
import 'package:al_hidayah/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentListView extends StatefulWidget {
  const StudentListView({super.key, required this.overviewBloc});
  final OverviewBloc overviewBloc;

  @override
  State<StudentListView> createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  String selectedClass = "Class 1";

  @override
  void initState() {
    super.initState();
    final overviewBloc = widget.overviewBloc;
    overviewBloc.add(StudentListInitialEvent(className: selectedClass));
  }

  List<String> dropdownItems = [
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5',
    'Class 6',
    'Class 7',
    'Class 8',
    'Class 9',
    'Class 10'
  ]; // List of dropdown items

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.overviewBloc.add(StudentOverInitialEvent());
        return true;
      },
      child: Scaffold(
        appBar: appBar(title: "Student List"),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DropdownButton<String>(
                  value: selectedClass,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedClass = newValue!;
                    });
                    widget.overviewBloc
                        .add(StudentListInitialEvent(className: selectedClass));
                  },
                  items: dropdownItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  isExpanded: true,
                ),
                BlocConsumer<OverviewBloc, OverviewState>(
                  bloc: widget.overviewBloc,
                  listenWhen: (previous, current) =>
                      current is OverviewActionState,
                  buildWhen: (previous, current) =>
                      current is! OverviewActionState,
                  listener: (context, state) {
                    if (state is StudentListAddNewButtonClickState) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StudentCreate(
                            overviewBloc: widget.overviewBloc,
                          ),
                        ),
                      );
                    }

                    if (state is StudentDetailViewButtonClickedState) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => StudentDetailView(
                                student: state.student,
                              )),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case StudentListLoadedSuccessState:
                        final successState =
                            state as StudentListLoadedSuccessState;

                        List<Student> students = successState.students;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columns: const [
                                    DataColumn(
                                      label: Text("Roll"),
                                      numeric: true,
                                    ),
                                    DataColumn(label: Text("Name")),
                                    // DataColumn(label: Text("Last name")),
                                    DataColumn(label: Text("Phone")),
                                    DataColumn(label: Text("")),
                                    // DataColumn(label: Text("Email")),
                                    // DataColumn(label: Text("DOB")),
                                    // DataColumn(label: Text("Address")),
                                    // DataColumn(label: Text("Parents Detail")),
                                  ],
                                  // columnSpacing: 20.0,
                                  // horizontalMargin: 10.0,
                                  rows: students.map((student) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(
                                            student.rollNumber.toString())),
                                        DataCell(Text(
                                            "${student.user.firstName} ${student.user.lastName}")),
                                        DataCell(
                                          TextButton(
                                            child: Text(
                                              student.user.phone.toString(),
                                            ),
                                            onPressed: () {
                                              launchUrl(Uri.parse(
                                                  "tel://${student.user.phone}"));
                                            },
                                          ),
                                        ),

                                        DataCell(
                                          TextButton(
                                            child: const Text("View"),
                                            onPressed: () {
                                              widget.overviewBloc.add(
                                                StudentDetailViewButtonClickEvent(
                                                  student,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        // DataCell(Text(student.user.email)),
                                        // DataCell(
                                        //   Text(
                                        //     DateFormat('dd-MM-yyyy')
                                        //         .format(student.user.dob),
                                        //   ),
                                        // ),
                                        // DataCell(Text(student.user.address)),
                                        // DataCell(Text(student.parentsDetail)),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                PrimaryButton(
                                  text: "Add new student",
                                  onPressed: () {
                                    widget.overviewBloc.add(
                                        StudentListAddNewButtonClickEvent(
                                            className: selectedClass));
                                  },
                                ),
                                SecondaryButton(
                                  text: "Upload sheet",
                                  onPressed: () {
                                    widget.overviewBloc.add(
                                        StudentListAddNewButtonClickEvent(
                                            className: selectedClass));
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        );
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
