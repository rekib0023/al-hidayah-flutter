part of 'overview_bloc.dart';

@immutable
abstract class OverviewEvent {}

class OverviewInitialEvent extends OverviewEvent {}

class StudentOverInitialEvent extends OverviewEvent {}

class EmployeeOverInitialEvent extends OverviewEvent {}

class TeacherOverInitialEvent extends OverviewEvent {}

class StudentListInitialEvent extends OverviewEvent {
  final String className;
  StudentListInitialEvent({required this.className});
}

class StudentListAddNewButtonClickEvent extends OverviewEvent {
  final String className;

  StudentListAddNewButtonClickEvent({required this.className});
}

class StudentCreateButtonClickEvent extends OverviewEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String dob;
  final String address;
  final String phone;
  final String className;
  final String parentsDetail;

  StudentCreateButtonClickEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dob,
    required this.address,
    required this.phone,
    required this.className,
    required this.parentsDetail,
  });
}

class StudentDetailViewButtonClickEvent extends OverviewEvent {
  final Student student;

  StudentDetailViewButtonClickEvent(this.student);
}
