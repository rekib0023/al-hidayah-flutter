part of 'calendar_bloc.dart';

@immutable
abstract class CalendarEvent {}

class CalendarEventInitial extends CalendarEvent {}

class CalendarEventCreate extends CalendarEvent {
  final Appointment appointment;

  CalendarEventCreate(this.appointment);
}

class CalendarEventDelete extends CalendarEvent {
  final Appointment appointment;

  CalendarEventDelete(this.appointment);
}
