import 'package:al_hidayah/features/overview/data_domain/employee.dart';
import 'package:al_hidayah/features/overview/data_domain/students.dart';
import 'package:al_hidayah/models/attendance.dart';
import 'package:al_hidayah/utils/constants.dart';
import 'package:al_hidayah/utils/dio_interceptors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ManagementService {
  late final Dio _dio;

  ManagementService() {
    _dio = Dio();
    _dio.options.baseUrl = "$apiBaseUrl/management";
    _dio.interceptors.add(DioInterceptor());
  }

  Future<List<Student>> getStudents() async {
    try {
      final response = await _dio.get("/students");
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        List<Student> students =
            data.map((json) => Student.fromJson(json)).toList();
        return students;
      } else {
        throw Exception('Failed to load students');
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      throw Exception('Failed to load students: $error');
    }
  }

  Future<List<Student>> getStudentsByClass(String classN) async {
    try {
      final response = await _dio.get("/students?class=$classN");
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        List<Student> students =
            data.map((json) => Student.fromJson(json)).toList();
        return students;
      } else {
        throw Exception('Failed to load students');
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      throw Exception('Failed to load students: $error');
    }
  }

  Future<Student> createStudent(Map<String, dynamic> student) async {
    try {
      final response = await _dio.post("/students", data: student);
      if (response.statusCode == 201) {
        Student student = Student.fromJson(response.data);
        return student;
      } else {
        throw Exception("Failed to create user");
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stackTrace");
      }
      throw Exception('Failed to create user: $error');
    }
  }

  Future<List<Employee>> getEmployees() async {
    try {
      final response = await _dio.get("/employees");
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        List<Employee> employees =
            data.map((json) => Employee.fromJson(json)).toList();
        return employees;
      } else {
        throw Exception('Failed to load employees');
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      throw Exception('Failed to load employees: $error');
    }
  }

  Future<Attendance> addAttendance(
    String userId,
    String date,
    String userType,
    bool isPresent,
    String? subject,
  ) async {
    try {
      Map<String, dynamic> payload = {
        "userId": userId,
        "date": date,
        "userType": userType,
        "isPresent": isPresent,
      };
      if (subject != null) {
        payload["subject"] = subject;
      }
      final response = await _dio.post("/attendance", data: payload);

      if (response.statusCode == 201) {
        Attendance attendance = Attendance.fromJson(response.data);
        return attendance;
      } else {
        throw Exception('Failed to load employees');
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      throw Exception('Failed to load employees: $error');
    }
  }
}
