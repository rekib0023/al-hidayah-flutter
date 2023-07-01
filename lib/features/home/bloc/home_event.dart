part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends AuthEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeStudentClassClickedEvent extends HomeEvent {
  final String className;
  HomeStudentClassClickedEvent({required this.className});
}

class HomeGridButtonClickEvent extends HomeEvent {
  final String name;

  HomeGridButtonClickEvent(this.name);
}
