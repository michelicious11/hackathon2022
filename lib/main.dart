import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SnapCity"),
        ),
      body:
          ElevatedButton(
          child: Text("Test"),
          onPressed: null),
      ),
    );
  }
}