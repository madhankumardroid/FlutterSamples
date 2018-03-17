import 'package:flutter/material.dart';
import 'strings.dart';
import 'firstFlutter.dart';

void main() => runApp(new FirstFlutterApp());

class FirstFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: Strings.appTitle,
      home: new FirstStateFulWidget(),
      theme: new ThemeData(primaryColor: Colors.pinkAccent));//Setting theme
  }
}