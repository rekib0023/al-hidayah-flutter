import 'dart:async';

import 'package:al_hidayah/features/expenses/data_domain/expense.dart';
import 'package:al_hidayah/features/expenses/data_domain/expense_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  ExpensesBloc() : super(ExpensesInitial()) {
    on<ExpensesInitialEvent>(expensesInitialEvent);
    on<ExpensesCreateEvent>(expensesCreateEvent);
  }

  FutureOr<void> expensesInitialEvent(
      ExpensesInitialEvent event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoadingState());
    List<ExpensesModel> expenses = await _expenseRepository.getAllExpenses();
    emit(ExpensesLoadedSuccessState(expenses));
  }

  FutureOr<void> expensesCreateEvent(
      ExpensesCreateEvent event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoadingState());
    List<ExpensesModel> expenses =
        await _expenseRepository.createExpense(event.expense);
    emit(ExpensesLoadedSuccessState(expenses));
  }
}
