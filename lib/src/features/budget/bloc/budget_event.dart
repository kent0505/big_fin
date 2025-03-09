part of 'budget_bloc.dart';

@immutable
sealed class BudgetEvent {}

final class GetBudgets extends BudgetEvent {}

final class AddBudget extends BudgetEvent {
  AddBudget({required this.budget});

  final Budget budget;
}

final class EditBudget extends BudgetEvent {
  EditBudget({required this.budget});

  final Budget budget;
}

final class DeleteBudget extends BudgetEvent {
  DeleteBudget({required this.budget});

  final Budget budget;
}
