import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/expense_repository.dart';
import '../models/expense.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository _repository;

  ExpenseBloc({required ExpenseRepository repository})
      : _repository = repository,
        super(ExpenseInitial()) {
    on<ExpenseEvent>(
      (event, emit) => switch (event) {
        GetExpenses() => _getExpenses(event, emit),
        AddExpense() => _addExpense(event, emit),
        EditExpense() => _editExpense(event, emit),
        DeleteExpense() => _deleteExpense(event, emit),
      },
    );
  }

  void _getExpenses(
    GetExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    List<Expense> expenses = await _repository.getExpenses();
    emit(ExpensesLoaded(expenses: expenses.reversed.toList()));
  }

  void _addExpense(
    AddExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    await _repository.addExpense(event.expense);
    add(GetExpenses());
  }

  void _editExpense(
    EditExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    await _repository.editExpense(event.expense);
    add(GetExpenses());
  }

  void _deleteExpense(
    DeleteExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    await _repository.deleteExpense(event.expense);
    add(GetExpenses());
  }
}
