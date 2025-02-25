import 'package:flutter/material.dart';
import 'package:flutter_test_task/DottedLineCheckboxRow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: DottedLineCheckboxRow(
                  text: "Interesting, how it could be collapsed into etc. Hmm, interesting, how it could be?",
                  initialChecked: isChecked
              ),
            ),
          ),
        ),
      ),
    );
  }
}
