import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// Create a constant Uuid instance for generating unique identifiers.
const uuid = Uuid();

// Create a formatter for formatting DateTime objects into strings.
final formatter = DateFormat.yMd();

// Define an enumeration named Category with four possible values.
enum Category { food, travel, leisure, work }

// Create a constant map associating each Category with a corresponding icon.
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.music_note,
  Category.work: Icons.work,
};

// Define a class named Expense representing an expense entry.
class Expense {
  // Constructor for Expense class.
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  // Final member variables representing the properties of an expense.
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // Getter method to format the date using the defined formatter.
  String get formattedDate {
    return formatter.format(date);
  }
}

// Define a class named ExpenseBucket representing a collection of expenses for a specific category.
class ExpenseBucket {
  // Constructor for ExpenseBucket class.
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  // Alternative constructor for ExpenseBucket class, filtering expenses for a specific category.
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  // Final member variables representing the properties of an expense bucket.
  final Category category;
  final List<Expense> expenses;

  // Getter method to calculate the total expenses for the category.
  double get totalExpenses {
    double sum = 0;

    for (final exp in expenses) {
      sum += exp.amount;
    }
    return sum;
  }
}
