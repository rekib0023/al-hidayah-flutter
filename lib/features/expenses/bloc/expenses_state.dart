part of 'expenses_bloc.dart';

@immutable
abstract class ExpensesState {}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoadingState extends ExpensesState {}

class ExpensesLoadedSuccessState extends ExpensesState {
  final List<ExpensesModel> expenses;

  ExpensesLoadedSuccessState(this.expenses);
}
