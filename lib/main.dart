import 'package:askmetre/others/strings.dart';
import 'package:flutter/material.dart';

import 'pages/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Strings strings = Strings();
    return MaterialApp(
      title: strings.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: strings.appName),
    );
  }
}
