part of 'expense_bloc.dart';

@immutable
sealed class ExpenseState {}

final class ExpenseInitial extends ExpenseState {}

final class ExpensesLoaded extends ExpenseState {
  ExpensesLoaded({required this.expenses});

  final List<Expense> expenses;
}
