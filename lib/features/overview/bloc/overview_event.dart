part of 'overview_bloc.dart';

@immutable
abstract class OverviewEvent {}

class OverviewInitialEvent extends OverviewEvent {}

class StudentOverInitialEvent extends OverviewEvent {}

class EmployeeOverInitialEvent extends OverviewEvent {}

class TeacherOverInitialEvent extends OverviewEvent {}
