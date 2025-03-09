import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/enums.dart';
import '../../../core/models/balance.dart';
import '../../../core/models/expense.dart';
import '../../../core/utils.dart';
import '../data/expense_repository.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository _repository;
  Period period = Period.monthly;

  ExpenseBloc({required ExpenseRepository repository})
      : _repository = repository,
        super(ExpenseInitial()) {
    on<ExpenseEvent>(
      (event, emit) => switch (event) {
        GetExpenses() => _getExpenses(event, emit),
        AddExpense() => _addExpense(event, emit),
        EditExpense() => _editExpense(event, emit),
        DeleteExpense() => _deleteExpense(event, emit),
        ChangePeriod() => _changePeriod(event, emit),
      },
    );
  }

  void _getExpenses(
    GetExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    List<Expense> expenses = await _repository.getExpenses();

    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(
      days: 6,
      hours: 23,
      minutes: 59,
      seconds: 59,
    ));

    List<Expense> sortedList = [];

    if (period == Period.monthly) {
      sortedList = expenses.where((expense) {
        DateTime date = stringToDate(expense.date);
        return date.year == now.year && date.month == now.month;
      }).toList();
    } else if (period == Period.weekly) {
      sortedList = expenses.where((expense) {
        DateTime date = stringToDate(expense.date);
        return (date.isAfter(startOfWeek) ||
                date.isAtSameMomentAs(startOfWeek)) &&
            (date.isBefore(endOfWeek) || date.isAtSameMomentAs(endOfWeek));
      }).toList();
    } else {
      sortedList = expenses.where((expense) {
        DateTime date = stringToDate(expense.date);
        return date.year == now.year &&
            date.month == now.month &&
            date.day == now.day;
      }).toList();
    }

    double x = 0;
    double y = 0;

    for (Expense expense in sortedList) {
      expense.isIncome
          ? x += double.tryParse(expense.amount) ?? 0
          : y += double.tryParse(expense.amount) ?? 0;
    }

    final sortedMonth = expenses.where((expense) {
      DateTime date = stringToDate(expense.date);
      return date.year == now.year && date.month == now.month;
    }).toList();
    double monthExpenses = 0;
    for (Expense expense in sortedMonth) {
      if (!expense.isIncome) {
        monthExpenses += double.tryParse(expense.amount) ?? 0;
      }
    }

    emit(ExpensesLoaded(
      expenses: expenses.reversed.toList(),
      period: period,
      balance: Balance(incomes: x, expenses: y),
      monthExpenses: monthExpenses,
    ));
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

  void _changePeriod(
    ChangePeriod event,
    Emitter<ExpenseState> emit,
  ) {
    period = event.period;
    add(GetExpenses());
  }
}
