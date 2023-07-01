part of 'calendar_bloc.dart';

List<Appointment> meetings = [];

@immutable
abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarEventCreateLoadingState extends CalendarState {}

class CalendarEventSuccessLoaded extends CalendarState {
  final List<Appointment> appointments;

  CalendarEventSuccessLoaded(this.appointments);
}
