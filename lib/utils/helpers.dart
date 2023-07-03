import 'dart:math';

import 'package:al_hidayah/models/attendance.dart';
import 'package:flutter/material.dart';

Color getRandomColor() {
  final random = Random();
  final colorIndex = random.nextInt(Colors.primaries.length);
  return Colors.primaries[colorIndex];
}

bool? getAttendance(List<Attendance> attendances, DateTime date) {
  for (Attendance attendance in attendances) {
    DateTime attendanceDate = attendance.date;
    if (attendanceDate.year == date.year &&
        attendanceDate.month == date.month &&
        attendanceDate.day == date.day) {
      return attendance.isPresent;
    }
  }
  return null;
}
