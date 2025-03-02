part of 'expense_bloc.dart';

@immutable
sealed class ExpenseEvent {}

final class GetExpenses extends ExpenseEvent {}

final class AddExpense extends ExpenseEvent {
  AddExpense({required this.expense});

  final Expense expense;
}

final class EditExpense extends ExpenseEvent {
  EditExpense({required this.expense});

  final Expense expense;
}

final class DeleteExpense extends ExpenseEvent {
  DeleteExpense({required this.expense});

  final Expense expense;
}
