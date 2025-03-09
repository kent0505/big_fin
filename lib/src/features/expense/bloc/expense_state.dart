part of 'expense_bloc.dart';

@immutable
sealed class ExpenseState {}

final class ExpenseInitial extends ExpenseState {}

final class ExpensesLoaded extends ExpenseState {
  ExpensesLoaded({
    required this.expenses,
    required this.period,
    required this.balance,
    required this.monthExpenses,
  });

  final List<Expense> expenses;
  final Period period;
  final Balance balance;
  final double monthExpenses;
}
