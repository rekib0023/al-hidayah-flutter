import 'dart:async';

import 'package:al_hidayah/features/overview/data_domain/employee.dart';
import 'package:al_hidayah/features/overview/data_domain/management_repositories.dart';
import 'package:al_hidayah/features/overview/data_domain/students.dart';
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
    on<StudentListInitialEvent>(studentListInitialEvent);
    on<StudentListAddNewButtonClickEvent>(studentListAddNewButtonClickEvent);
    on<StudentCreateButtonClickEvent>(studentCreateButtonClickEvent);
    on<StudentDetailViewButtonClickEvent>(studentDetailViewButtonClickEvent);
    on<EmployeeAttendanceBtnClickEvent>(employeeAttendanceBtnClickEvent);
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
      EmployeeOverInitialEvent event, Emitter<OverviewState> emit) async {
    emit(EmployeeLoadingState());
    List<Employee> employees = await _managementRepository.getAllEmployees();
    emit(EmployeeLoadedSuccessState(employees: employees));
  }

  FutureOr<void> teacherOverInitialEvent(
      TeacherOverInitialEvent event, Emitter<OverviewState> emit) {}

  FutureOr<void> studentListInitialEvent(
      StudentListInitialEvent event, Emitter<OverviewState> emit) async {
    emit(StudentListLoadingState());
    List<Student> students =
        await _managementRepository.getStudentsByClass(event.className);
    emit(StudentListLoadedSuccessState(students: students));
  }

  FutureOr<void> studentListAddNewButtonClickEvent(
      StudentListAddNewButtonClickEvent event, Emitter<OverviewState> emit) {
    emit(StudentListAddNewButtonClickState(className: event.className));
  }

  FutureOr<void> studentCreateButtonClickEvent(
      StudentCreateButtonClickEvent event, Emitter<OverviewState> emit) async {
    emit(StudentCreateLoadingState());
    Student student = await _managementRepository.createStudent(
      event.firstName,
      event.lastName,
      event.email,
      event.dob,
      event.address,
      event.phone,
      event.className,
      event.parentsDetail,
    );
    emit(StudentCreatedSuccessState(student));
  }

  FutureOr<void> studentDetailViewButtonClickEvent(
      StudentDetailViewButtonClickEvent event, Emitter<OverviewState> emit) {
    emit(StudentDetailViewButtonClickedState(event.student));
  }

  FutureOr<void> employeeAttendanceBtnClickEvent(
      EmployeeAttendanceBtnClickEvent event,
      Emitter<OverviewState> emit) async {
    await _managementRepository.addAttendance(
      event.userId,
      event.date.toString(),
      event.userType,
      event.isPresent,
      event.subject,
    );

    emit(EmployeeAttendanceAddedActionState());
  }
}
