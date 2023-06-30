import 'package:al_hidayah/features/overview/bloc/overview_bloc.dart';
import 'package:al_hidayah/features/overview/ui/student_overview/Student_Chart.dart';
import 'package:al_hidayah/features/overview/ui/student_overview/student_listview.dart';
import 'package:al_hidayah/models/students.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentOverview extends StatefulWidget {
  const StudentOverview({super.key});

  @override
  State<StudentOverview> createState() => _StudentOverviewState();
}

class _StudentOverviewState extends State<StudentOverview> {
  @override
  void initState() {
    overviewBloc.add(StudentOverInitialEvent());
    super.initState();
  }

  final OverviewBloc overviewBloc = OverviewBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OverviewBloc, OverviewState>(
        bloc: overviewBloc,
        listenWhen: (previous, current) => current is OverviewActionState,
        buildWhen: (previous, current) => current is! OverviewActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case StudentOverLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case StudentLoadedSuccessState:
              final successState = state as StudentLoadedSuccessState;
              List<Student> students = successState.students;
              int totalEnrolled = students.length;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => StudentListView(
                                      overviewBloc: overviewBloc,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(24.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Total Enrolled:\n$totalEnrolled Students',
                                  style: AppTextStyles.title,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 400,
                        child: buildBarChart(students),
                      ),
                    ],
                  ),
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
