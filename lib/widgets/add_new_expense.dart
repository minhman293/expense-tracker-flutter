import 'dart:html';

import 'package:flutter/material.dart';

import 'package:expenses_tracker/models/expense.dart';

class AddNewExpense extends StatefulWidget {
  const AddNewExpense({super.key, required this.onNewExpense});

  final void Function(Expense expense) onNewExpense;

  @override
  State<AddNewExpense> createState() {
    return _AddNewExpenseState();
  }
}

class _AddNewExpenseState extends State<AddNewExpense> {
  // every input needs a controller
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.work;

  @override
  void dispose() {
    // this method?
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _pressDateIcon() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _validateSubmitData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final title = _titleController.text.trim();

    // check
    if (title.isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0 ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Data'),
          content: const Text('Please check input data again!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }

    widget.onNewExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    // auto responsive horizontal layout
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          // number of available characters in textfield
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('title'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          // number of available characters in textfield
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$',
                            label: Text('amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    // number of available characters in textfield
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('title'),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              // map is used to transform each Category value into a DropdownMenuItem
                              .map(
                                (category) => DropdownMenuItem(
                                  // value is invisible to user
                                  value: category,
                                  // Text(category.name) creates a text widget for each category using the name property of the enum
                                  child: Text(category.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const SizedBox(width: 24,),
                      Expanded(
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No selected date'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _pressDateIcon,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                else 
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                            // number of available characters in textfield
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '\$',
                              label: Text('amount'),
                            ),
                          ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                          child: Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _selectedDate == null
                                      ? 'No selected date'
                                      : formatter.format(_selectedDate!),
                                ),
                                IconButton(
                                  onPressed: _pressDateIcon,
                                  icon: const Icon(Icons.calendar_month),
                                ),
                              ],
                            ),
                          ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _validateSubmitData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  ),
                else 
                  Row(children: [
                    DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              // map is used to transform each Category value into a DropdownMenuItem
                              .map(
                                (category) => DropdownMenuItem(
                                  // value is invisible to user
                                  value: category,
                                  // Text(category.name) creates a text widget for each category using the name property of the enum
                                  child: Text(category.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _validateSubmitData,
                        child: const Text('Save Expense'),
                      ),
                  ],),
              ],
            ),
          ),
        ),
      );
    });
  }
}
