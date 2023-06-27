part of 'overview_bloc.dart';

@immutable
abstract class OverviewState {}

abstract class OverviewActionState extends OverviewState {}

class OverviewInitial extends OverviewState {}

class StudentOverInitial extends OverviewInitial {}

class EmployeeOverInitial extends OverviewInitial {}

class TeacherOverInitial extends OverviewInitial {}

class StudentOverLoadingState extends OverviewState {}

class EmployeeLoadingState extends OverviewState {}

class TeacherLoadingState extends OverviewState {}

class StudentLoadedSuccessState extends OverviewState {
  final List<Student> students;

  StudentLoadedSuccessState({required this.students});
}
