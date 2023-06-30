import 'package:al_hidayah/models/notices.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../utils/constants.dart';
import '../../../utils/dio_interceptors.dart';

class AnnouncementService {
  late final Dio _dio;

  AnnouncementService() {
    _dio = Dio();
    _dio.options.baseUrl = apiBaseUrl;
    _dio.interceptors.add(DioInterceptor());
  }

  Future<Notice> createNotices(String title, String description) async {
    try {
      Map<String, dynamic> jsonData = {
        "title": title,
        "description": description,
      };

      final response = await _dio.post(
        '/notices',
        data: jsonData,
      );

      if (response.statusCode == 201) {
        return Notice.fromJson(response.data);
      } else {
        throw Exception("Failed to create notice");
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      throw Exception("Failed to create notice");
    }
  }

  Future<NoticeList> getNotices(
    String limit,
    String offset,
    String title,
    String showAll,
  ) async {
    try {
      final response = await _dio.get(
        '/notices',
        queryParameters: {
          'limit': limit,
          'offset': offset,
          'title': title,
          'showAll': showAll,
        },
      );
      if (response.statusCode == 200) {
        return NoticeList.fromJson(response.data);
      } else {
        throw Exception("Failed to get notice");
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      throw Exception("Failed to get notices");
    }
  }
}
