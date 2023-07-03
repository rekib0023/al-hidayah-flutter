import 'package:al_hidayah/features/expenses/data_domain/expense.dart';
import 'package:al_hidayah/utils/constants.dart';
import 'package:al_hidayah/utils/dio_interceptors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ExpenseService {
  late final Dio _dio;

  ExpenseService() {
    _dio = Dio();
    _dio.options.baseUrl = apiBaseUrl;
    _dio.interceptors.add(DioInterceptor());
  }

  Future<List<ExpensesModel>> getAllExpenses() async {
    try {
      final response = await _dio.get("/expenses");
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        List<ExpensesModel> expenses =
            data.map((json) => ExpensesModel.fromJson(json)).toList();

        return expenses;
      } else {
        throw Exception("Failed to get expenses");
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      throw Exception("Failed to get expenses");
    }
  }

  Future<List<ExpensesModel>> createExpense(Expense expense) async {
    try {
      final response = await _dio.post("/expenses", data: expense.toJson());
      if (response.statusCode == 201) {
        final response = await _dio.get("/expenses");
        if (response.statusCode == 200) {
          final data = response.data as List<dynamic>;
          List<ExpensesModel> expenses =
              data.map((json) => ExpensesModel.fromJson(json)).toList();

          return expenses;
        } else {
          throw Exception("Failed to get expenses");
        }
      } else {
        throw Exception("Failed to creates expense");
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      throw Exception("Failed to creates expense");
    }
  }
}
