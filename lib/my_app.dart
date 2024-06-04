import 'package:flutter/material.dart';
import 'tab_bar_example.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBarExample(),
    );
  }
}
