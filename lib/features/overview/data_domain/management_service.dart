import 'package:al_hidayah/models/students.dart';
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
}