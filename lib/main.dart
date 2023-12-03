import 'package:flutter/material.dart';

import 'widgets/expenses_widget.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.amber,
      ),
      home: const Expenses(),
    ),
  );
}
