import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/expenses_widget.dart';

void main() {
  // set locked screen
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then((fn) {
    runApp(
      MaterialApp(
        theme: ThemeData().copyWith(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.amber,
        ),
        home: const Expenses(),
      ),
    );
  });
}
