part of 'expenses_bloc.dart';

@immutable
abstract class ExpensesEvent {}

class ExpensesInitialEvent extends ExpensesEvent {}

class ExpensesCreateEvent extends ExpensesEvent {
  final Expense expense;

  ExpensesCreateEvent(this.expense);
}
