import 'package:al_hidayah/features/overview/bloc/overview_bloc.dart';
import 'package:al_hidayah/features/overview/data_domain/employee.dart';
import 'package:al_hidayah/features/overview/ui/employee_overview/employee_listview.dart';
import 'package:al_hidayah/models/users.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:al_hidayah/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EmployeeOverview extends StatefulWidget {
  const EmployeeOverview({super.key});

  @override
  State<EmployeeOverview> createState() => _EmployeeOverviewState();
}

class _EmployeeOverviewState extends State<EmployeeOverview> {
  final OverviewBloc overviewBloc = OverviewBloc();

  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    overviewBloc.add(EmployeeOverInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OverviewBloc, OverviewState>(
      bloc: overviewBloc,
      listenWhen: (previous, current) => current is OverviewActionState,
      buildWhen: (previous, current) => current is! OverviewActionState,
      listener: (context, state) {
        if (state is EmployeeAttendanceAddedActionState) {
          overviewBloc.add(EmployeeOverInitialEvent());
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case EmployeeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case EmployeeLoadedSuccessState:
            final successState = state as EmployeeLoadedSuccessState;
            List<Employee> employees = successState.employees;
            int totalEmployees = employees.length;
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EmployeeListView(
                                    overviewBloc: overviewBloc,
                                    employees: employees,
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
                                'Total Employees:\n$totalEmployees',
                                style: AppTextStyles.title,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Attendance",
                          style: AppTextStyles.title,
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              setState(() {
                                _selectedDate = selectedDate;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Text(DateFormat.yMd().format(_selectedDate)),
                              const SizedBox(width: 8),
                              const Icon(Icons.schedule),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: totalEmployees,
                        itemBuilder: (context, index) {
                          User user = employees[index].user!;
                          bool? isPresent = getAttendance(
                              employees[index].attendance!, _selectedDate);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${user.firstName} ${user.lastName}"),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      overviewBloc.add(
                                        EmployeeAttendanceBtnClickEvent(
                                          userId: employees[index].sId!,
                                          isPresent: true,
                                          date: _selectedDate,
                                          userType: "staff",
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 24,
                                      width: 24,
                                      decoration: BoxDecoration(
                                        border: isPresent != true
                                            ? Border.all(
                                                color: Colors.green,
                                                width: 1.0,
                                              )
                                            : null,
                                        color: isPresent != true
                                            ? Colors.white
                                            : Colors.green,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "P",
                                          style: TextStyle(
                                            color: isPresent != true
                                                ? Colors.green
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      overviewBloc.add(
                                        EmployeeAttendanceBtnClickEvent(
                                          userId: employees[index].sId!,
                                          isPresent: false,
                                          date: _selectedDate,
                                          userType: "staff",
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: isPresent != false
                                            ? Border.all(
                                                color: Colors.red,
                                                width: 1.0,
                                              )
                                            : null,
                                        color: isPresent != false
                                            ? Colors.white
                                            : Colors.red,
                                      ),
                                      height: 24,
                                      width: 24,
                                      child: Center(
                                        child: Text(
                                          "A",
                                          style: TextStyle(
                                            color: isPresent != false
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          default:
            return const Scaffold(
              body: SizedBox(),
            );
        }
      },
    );
  }
}
