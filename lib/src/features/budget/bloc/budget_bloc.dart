import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/budget.dart';
import '../../../core/models/cat.dart';
import '../../../core/utils.dart';
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

  void _addBudget(
    AddBudget event,
    Emitter<BudgetState> emit,
  ) async {
    int id = getTimestamp();
    // for (var _ in event.cats) {
    //   await _repository.addBudget(Budget(
    //     id: id,
    //     date: date,
    //     limit: limit,
    //     catID: catID,
    //     catLimit: catLimit,
    //   ));
    // }
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
