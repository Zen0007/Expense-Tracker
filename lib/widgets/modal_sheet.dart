import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:make_your_plan/model/expense.dart';

class SheetBottom extends StatefulWidget {
  const SheetBottom({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<SheetBottom> createState() => _SheetBottomState();
}

class _SheetBottomState extends State<SheetBottom> {
  final _textEditingControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime? _dateTime;
  Category _chooseCategory = Category.work;

  void _sumbitData() {
    final dataAmout = double.tryParse(_amountControler.text);
    final dataAmoutNull = dataAmout == null || dataAmout <= 0;
    if (_textEditingControler.text.trim().isEmpty ||
        dataAmoutNull ||
        _dateTime == null) {
      platfom();
      return;
    }
    widget.onAddExpense(Expense(
      title: _textEditingControler.text,
      amount: dataAmout,
      date: _dateTime!,
      category: _chooseCategory,
    ));
    Navigator.pop(context);
  }

  void platfom() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text("invalid input "),
          content: const Text('please fill all the input before in summbit'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('okey'),
            )
          ],
        ),
      );
      return;
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("invalid input "),
          content: const Text('please fill all the input before in summbit'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('okey'),
            )
          ],
        ),
      );
      return;
    }
  }

  void _presetDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
      initialDate: now,
    );
    setState(() {
      _dateTime = pickDate;
    });
  }

  @override
  void dispose() {
    _textEditingControler.dispose();
    _amountControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBordSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        final widith = constraints.maxWidth;
        //---------------------\
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25.0, 40.0, 25.0, keyBordSpace + 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widith >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TextField(
                                controller: _textEditingControler,
                                maxLength: 100,
                                decoration: const InputDecoration(
                                  label: Text('Title'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _amountControler,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: "\$",
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _textEditingControler,
                      maxLength: 100,
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                    ),
                  if (widith >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _chooseCategory,
                          items: Category.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _chooseCategory = value;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_dateTime == null
                                  ? "not date selected"
                                  : dataFormat.format(_dateTime!)),
                              IconButton(
                                onPressed: _presetDate,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountControler,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: "\$",
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_dateTime == null
                                  ? "not date selected"
                                  : dataFormat.format(_dateTime!)),
                              IconButton(
                                onPressed: _presetDate,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 30),
                  if (widith >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("CANCEL"),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          onPressed: _sumbitData,
                          child: const Text("SUMBIT"),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          value: _chooseCategory,
                          items: Category.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _chooseCategory = value;
                            });
                          },
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("CANCEL"),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          onPressed: _sumbitData,
                          child: const Text("SUMBIT"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
