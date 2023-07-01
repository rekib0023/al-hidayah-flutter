import 'package:al_hidayah/features/calendar/data_domain/calendar_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarRepository {
  final CalendarService _apiService = CalendarService();

  Future<List<Appointment>> getCalendarEvents() async {
    try {
      return await _apiService.getCalendarEvents();
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }
}
