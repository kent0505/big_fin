part of 'budget_bloc.dart';

@immutable
sealed class BudgetState {}

final class BudgetInitial extends BudgetState {}

final class BudgetsLoaded extends BudgetState {
  BudgetsLoaded({required this.budgets});

  final List<Budget> budgets;
}
