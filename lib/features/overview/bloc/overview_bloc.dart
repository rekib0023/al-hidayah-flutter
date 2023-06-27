import 'dart:async';

import 'package:al_hidayah/features/overview/data_domain/management_repositories.dart';
import 'package:al_hidayah/models/students.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'overview_event.dart';
part 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final ManagementRepository _managementRepository = ManagementRepository();
  OverviewBloc() : super(OverviewInitial()) {
    on<OverviewInitialEvent>(overviewInitialEvent);
    on<StudentOverInitialEvent>(studentOverInitialEvent);
    on<EmployeeOverInitialEvent>(employeeOverInitialEvent);
    on<TeacherOverInitialEvent>(teacherOverInitialEvent);
  }

  FutureOr<void> overviewInitialEvent(
      OverviewInitialEvent event, Emitter<OverviewState> emit) {}

  FutureOr<void> studentOverInitialEvent(
      StudentOverInitialEvent event, Emitter<OverviewState> emit) async {
    emit(StudentOverLoadingState());
    List<Student> students = await _managementRepository.getStudents();
    emit(StudentLoadedSuccessState(students: students));
  }

  FutureOr<void> employeeOverInitialEvent(
      EmployeeOverInitialEvent event, Emitter<OverviewState> emit) {}

  FutureOr<void> teacherOverInitialEvent(
      TeacherOverInitialEvent event, Emitter<OverviewState> emit) {}
}
