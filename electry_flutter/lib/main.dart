import 'package:electry_flutter/MainLayout/Login_layout.dart';
import 'package:electry_flutter/widgets/Responsive/nav_layout.dart';
import 'package:flutter/material.dart';
import 'package:electry_flutter/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      home: new LoginLayout(),
    );
  }
}
