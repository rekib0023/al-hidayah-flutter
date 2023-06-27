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

class StudentListLoadingState extends OverviewState {}

class StudentListInitialState extends OverviewState {}

class StudentListLoadedSuccessState extends OverviewState {
  final List<Student> students;

  StudentListLoadedSuccessState({required this.students});
}

class StudentListAddNewButtonClickState extends OverviewActionState {
  final String className;

  StudentListAddNewButtonClickState({required this.className});
}

class StudentCreateLoadingState extends OverviewState {}

class StudentCreateNewButtonClickState extends OverviewActionState {}

class StudentCreatedSuccessState extends OverviewActionState {
  final Student student;

  StudentCreatedSuccessState(this.student);
}

class StudentCreateIntialState extends OverviewInitial {}

class StudentDetailViewButtonClickedState extends OverviewActionState {
  final Student student;

  StudentDetailViewButtonClickedState(this.student);
}
