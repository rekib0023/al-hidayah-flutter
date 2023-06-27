import 'package:al_hidayah/utils/constants.dart';
import 'package:al_hidayah/utils/dio_interceptors.dart';
import 'package:al_hidayah/utils/store.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../models/users.dart';

class AuthService {
  // final Dio _dio = getDio();
  late final Dio _dio;

  AuthService() {
    _dio = Dio();
    _dio.options.baseUrl = apiBaseUrl;
    _dio.interceptors.add(DioInterceptor());
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
        final String token =
            response.headers['set-cookie']![0].split(";")[0].split("=")[1];
        await Store.setToken(token);
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
