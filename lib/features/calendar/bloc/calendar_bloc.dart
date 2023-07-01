import 'dart:async';

import 'package:al_hidayah/features/calendar/data_domain/calendar_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarRepository _calendarRepository = CalendarRepository();
  CalendarBloc() : super(CalendarInitial()) {
    on<CalendarEventInitial>(calendarEventInitial);
    on<CalendarEventCreate>(calendarEventCreate);
    on<CalendarEventDelete>(calendarEventDelete);
  }

  FutureOr<void> calendarEventCreate(
      CalendarEventCreate event, Emitter<CalendarState> emit) {
    emit(CalendarEventCreateLoadingState());
    meetings.add(event.appointment);
    emit(CalendarEventSuccessLoaded(meetings));
  }

  FutureOr<void> calendarEventInitial(
      CalendarEventInitial event, Emitter<CalendarState> emit) async {
    List<Appointment> appointments =
        await _calendarRepository.getCalendarEvents();
    emit(CalendarEventSuccessLoaded(appointments));
  }

  FutureOr<void> calendarEventDelete(
      CalendarEventDelete event, Emitter<CalendarState> emit) {
    var index = -1;
    for (int i = 0; i < meetings.length; i++) {
      Appointment appointment = meetings[i];
      if (appointment.id == event.appointment.id) {
        index = i;
      }
    }
    if (index != -1) {
      meetings.removeAt(index);
    }
    emit(CalendarEventSuccessLoaded(meetings));
  }
}
