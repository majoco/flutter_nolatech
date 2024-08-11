import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/Views/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const SecondScreen(dataFromFirst: 'Data from First Screen')),
            );

            if (result != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Received result: $result'),
                ),
              );
            }
          },
          child: const Text('Go to Second Screen'),
        ),
      ),
    );
  }
}
