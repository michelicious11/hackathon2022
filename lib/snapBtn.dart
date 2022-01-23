import 'package:flutter/material.dart';

class SnapBtn extends StatelessWidget {
  final selectHandler;

  SnapBtn(this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.amber,
        textColor: Colors.white,
        child: Text("Snap!"),
        onPressed: selectHandler,
      ),
    );
  }
}