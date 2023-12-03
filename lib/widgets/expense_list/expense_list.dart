import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenseList,
    required this.onRemoveExpense,
  });

  final List<Expense> expenseList;

  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: (ctx, idx) => Dismissible(
        onDismissed: (direction) {
          onRemoveExpense(expenseList[idx]);
        },
        key: ValueKey(expenseList[idx]),
        child: ExpenseItem(expenseList[idx]),
      ),
    );
  }
}
