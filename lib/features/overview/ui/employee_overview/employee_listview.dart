import 'package:al_hidayah/features/overview/bloc/overview_bloc.dart';
import 'package:al_hidayah/features/overview/data_domain/employee.dart';
import 'package:al_hidayah/widgets/App_Bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeListView extends StatefulWidget {
  const EmployeeListView(
      {super.key, required this.overviewBloc, required this.employees});
  final OverviewBloc overviewBloc;
  final List<Employee> employees;

  @override
  State<EmployeeListView> createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  @override
  Widget build(BuildContext context) {
    List<Employee> employees = widget.employees;
    return WillPopScope(
      onWillPop: () async {
        widget.overviewBloc.add(EmployeeOverInitialEvent());
        return true;
      },
      child: Scaffold(
        appBar: appBar(title: "Employee List"),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocConsumer<OverviewBloc, OverviewState>(
                  bloc: widget.overviewBloc,
                  listenWhen: (previous, current) =>
                      current is OverviewActionState,
                  buildWhen: (previous, current) =>
                      current is! OverviewActionState,
                  listener: (context, state) {},
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case EmployeeLoadedSuccessState:
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
                                      label: Text("Employee Number"),
                                    ),
                                    DataColumn(label: Text("Name")),
                                    DataColumn(label: Text("Department")),
                                    DataColumn(label: Text("Phone")),
                                    DataColumn(label: Text("")),
                                  ],
                                  rows: employees.map((employee) {
                                    return DataRow(cells: [
                                      DataCell(
                                        Text(
                                          employee.employeeNumber.toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          "${employee.user!.firstName} ${employee.user!.lastName}",
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          employee.department!,
                                        ),
                                      ),
                                      DataCell(
                                        TextButton(
                                          child: Text(
                                            employee.user!.phone.toString(),
                                          ),
                                          onPressed: () {
                                            launchUrl(
                                              Uri.parse(
                                                "tel://${employee.user!.phone}",
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        TextButton(
                                          child: const Text("View"),
                                          onPressed: () {
                                            // widget.overviewBloc.add(
                                            //   StudentDetailViewButtonClickEvent(
                                            //     student,
                                            //   ),
                                            // );
                                          },
                                        ),
                                      ),
                                    ]);
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        );
                      default:
                        return const SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
