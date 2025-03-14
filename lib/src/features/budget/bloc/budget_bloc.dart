import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/budget.dart';
import '../data/budget_repository.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final BudgetRepository _repository;

  BudgetBloc({required BudgetRepository repository})
      : _repository = repository,
        super(BudgetInitial()) {
    on<BudgetEvent>(
      (event, emit) => switch (event) {
        GetBudgets() => _getBudgets(event, emit),
        CheckBudget() => _checkBudget(event, emit),
        AddBudget() => _addBudget(event, emit),
        EditBudget() => _editBudget(event, emit),
        DeleteBudget() => _deleteBudget(event, emit),
      },
    );
  }

  void _getBudgets(
    GetBudgets event,
    Emitter<BudgetState> emit,
  ) async {
    List<Budget> budgets = await _repository.getBudgets();
    emit(BudgetsLoaded(budgets: budgets));
  }

  void _checkBudget(
    CheckBudget event,
    Emitter<BudgetState> emit,
  ) async {
    List<Budget> budgets = await _repository.getBudgets();
    for (Budget budget in budgets) {
      if (budget.id != event.budget.id &&
          budget.date == event.budget.date &&
          budget.monthly == event.budget.monthly) {
        emit(BudgetExists());
        emit(BudgetsLoaded(budgets: budgets));
        return;
      }
    }
    emit(BudgetNotExists());
    emit(BudgetsLoaded(budgets: budgets));
  }

  void _addBudget(
    AddBudget event,
    Emitter<BudgetState> emit,
  ) async {
    await _repository.addBudget(event.budget);
    add(GetBudgets());
  }

  void _editBudget(
    EditBudget event,
    Emitter<BudgetState> emit,
  ) async {
    await _repository.editBudget(event.budget);
    add(GetBudgets());
  }

  void _deleteBudget(
    DeleteBudget event,
    Emitter<BudgetState> emit,
  ) async {
    await _repository.deleteBudget(event.budget);
    add(GetBudgets());
  }
}
