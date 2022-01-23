import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'SnapBtn.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    //TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _test = 0;

  void _takePicture() {
    setState(() {
      _test++;
    });
    print("test");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SnapCity"),
        ),
      body: SnapBtn(_takePicture),
      ),
    );
  }
}