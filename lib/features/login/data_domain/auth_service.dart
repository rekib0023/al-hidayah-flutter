import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../models/users.dart';
import '../../../utils/constants.dart';

class AuthService {
  final Dio _dio = Dio();

  AuthService() {
    _dio.options.baseUrl = apiBaseUrl;
    _dio.options.connectTimeout = const Duration(milliseconds: 5000);
  }

  Future<User> loginUser(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {
          "email": email,
          "password": password,
          "type": "management",
        },
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data["data"]);
      } else {
        throw Exception('Failed to create user');
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      throw Exception('Failed to create user: $error');
    }
  }
}
