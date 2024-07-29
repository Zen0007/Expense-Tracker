import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dataFormat = DateFormat.yMEd();

enum Category {
  work,
  food,
  resd,
  trip,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining_outlined,
  Category.trip: Icons.flight_takeoff_rounded,
  Category.resd: Icons.movie_creation_outlined,
  Category.work: Icons.work_history_outlined,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;

  get formattedDate {
    return dataFormat.format(date);
  }
}

class ExpenseBar {
  const ExpenseBar({required this.category, required this.expense});
  final Category category;
  final List<Expense> expense;

  ExpenseBar.forCategory(List<Expense> allExpenses, this.category)
      : expense = allExpenses
            .where((element) => element.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;

    for (final element in expense) {
      sum += element.amount;
    }
    return sum;
  }
}
