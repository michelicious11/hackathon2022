import 'camera.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'SnapCity',
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SnapCity'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Snap!'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Camera();

  }
}