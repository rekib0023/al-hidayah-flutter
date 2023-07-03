import 'package:al_hidayah/features/expenses/data_domain/expense.dart';
import 'package:al_hidayah/features/expenses/data_domain/expense_service.dart';

class ExpenseRepository {
  final ExpenseService _apiService = ExpenseService();

  Future<List<ExpensesModel>> getAllExpenses() async {
    try {
      return await _apiService.getAllExpenses();
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<List<ExpensesModel>> createExpense(Expense expense) async {
    try {
      return await _apiService.createExpense(expense);
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }
}
