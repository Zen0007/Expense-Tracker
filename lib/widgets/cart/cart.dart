import 'package:flutter/material.dart';
import 'package:make_your_plan/model/expense.dart';
import 'package:make_your_plan/widgets/cart/cart_bar.dart';

class Cart extends StatelessWidget {
  const Cart({super.key, required this.expense});
  final List<Expense> expense;
  List<ExpenseBar> get bar {
    return [
      ExpenseBar.forCategory(expense, Category.food),
      ExpenseBar.forCategory(expense, Category.resd),
      ExpenseBar.forCategory(expense, Category.work),
      ExpenseBar.forCategory(expense, Category.trip),
    ];
  }

  double get maxTotalExpenses {
    double maxTotalExpenses = 0;
    for (var element in bar) {
      if (element.totalExpenses > maxTotalExpenses) {
        maxTotalExpenses = element.totalExpenses;
      }
    }
    return maxTotalExpenses;
  }

  @override
  Widget build(BuildContext context) {
    final darkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.8)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bars in bar)
                  Cartbar(
                    fill: bars.totalExpenses == 0
                        ? 0
                        : bars.totalExpenses / maxTotalExpenses,
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: bar
                .map(
                  (e) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        categoryIcons[e.category],
                        color: darkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
