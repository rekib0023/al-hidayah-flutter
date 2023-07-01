import 'package:al_hidayah/utils/constants.dart';
import 'package:al_hidayah/utils/dio_interceptors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarService {
  late final Dio _dio;

  CalendarService() {
    _dio = Dio();
    _dio.options.baseUrl = apiBaseUrl;
    _dio.interceptors.add(DioInterceptor());
  }

  Future<List<Appointment>> getCalendarEvents() async {
    try {
      final response = await _dio.get("/events");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Appointment> appointments = data.map((element) {
          return Appointment(
            id: element["id"],
            startTime: DateTime.parse(element["startTime"]),
            endTime: DateTime.parse(element["endTime"]),
            subject: element["subject"],
            isAllDay: element["isAllDay"],
            color: Color(int.parse(element["color"].substring(1), radix: 16) +
                0xFF000000),
            startTimeZone: element["startTimeZone"],
            endTimeZone: element["endTimeZone"],
            recurrenceRule: element["recurrenceRule"],
          );
        }).toList();
        return appointments;
      } else {
        throw Exception("Failed to get events");
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      throw Exception("Failed to get events");
    }
  }
}
