import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  final String dataFromFirst;

  const SecondScreen({super.key, required this.dataFromFirst});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Data from First Screen: ${widget.dataFromFirst}'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Data from Second Screen');
              },
              child: const Text('Send Data to First Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
