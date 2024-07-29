import 'package:flutter/material.dart';
import 'package:make_your_plan/widgets/cart/cart.dart';
import 'package:make_your_plan/widgets/expenses_list/expense_list.dart';
import 'package:make_your_plan/model/expense.dart';
import 'package:make_your_plan/widgets/modal_sheet.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_field
  final List<Expense> _dummyData = [
    Expense(
      title: "home work",
      amount: 1,
      date: DateTime.now(),
      category: Category.resd,
    ),
    Expense(
      title: 'late wake up',
      amount: 4,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _dummyData.add(expense);
    });
  }

  void _remove(Expense expense) {
    final index = _dummyData.indexOf(expense);
    setState(() {
      _dummyData.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text("expenses deleted"),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _dummyData.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  void _opendSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => SheetBottom(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    final widith = MediaQuery.of(context).size.width;

    Widget mainControler = const Center(
      child: Text("No expenses found, Start adding some !"),
    );

    if (_dummyData.isNotEmpty) {
      mainControler = ExpenseList(
        expense: _dummyData,
        remove: _remove,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Tracker',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: _opendSheet,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: widith < 600
          ? Column(
              children: [
                Cart(expense: _dummyData),
                Expanded(
                  child: mainControler,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Cart(expense: _dummyData),
                ),
                Expanded(
                  child: mainControler,
                )
              ],
            ),
    );
  }
}
