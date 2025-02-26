import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Material App Bar')),
        body: Center(
          child: Column(
            children: [
              Text('Hello World'),
              ElevatedButton(onPressed: () {}, child: const Text('Click Me')),
            ],
          ),
        ),
      ),
    );
  }
}
