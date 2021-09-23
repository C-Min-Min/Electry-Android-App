import 'package:electry_flutter/widgets/DataTabelMySQLDemo/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
      ),
      home: new App(),
    );
  }
}
