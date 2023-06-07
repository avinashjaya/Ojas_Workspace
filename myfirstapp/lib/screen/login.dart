import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Image Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://img.freepik.com/free-vector/design-process-concept-landing-page_23-2148313670.jpg?w=2000', // Replace with your image path
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              Image.network(
                'https://img.freepik.com/free-vector/design-process-concept-landing-page_23-2148313670.jpg?w=2000', // Replace with your image URL
                width: 200,
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
