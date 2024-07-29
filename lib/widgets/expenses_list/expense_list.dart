import 'package:flutter/material.dart';
import 'package:make_your_plan/model/expense.dart';
import 'package:make_your_plan/widgets/expenses_list/expenses_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expense, required this.remove});

  final List<Expense> expense;
  final void Function(Expense expense) remove;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expense[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withAlpha(150),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          remove(expense[index]);
        },
        child: ExpenseItems(
          expense: expense[index],
        ),
      ),
    );
  }
}
