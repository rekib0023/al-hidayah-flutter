part of 'home_bloc.dart';

@immutable
abstract class HomeState extends AuthState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<Student> students;

  HomeLoadedSuccessState({required this.students});
}

class HomeErrorState extends HomeState {}

class HomeStudentViewClassClickedActionState extends HomeActionState {
  final String className;

  HomeStudentViewClassClickedActionState({required this.className});
}

class HomeGridCalendarClickedActionState extends HomeActionState {}

class HomeGridStoreClickedActionState extends HomeActionState {}

class HomeGridExpensesClickedActionState extends HomeActionState {}
