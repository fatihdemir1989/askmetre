import 'package:askmetre/others/strings.dart';
import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Strings strings = Strings();
    return Image.asset(strings.appBarIcon,
        color: Colors.red.shade800, fit: BoxFit.contain);
  }
}
