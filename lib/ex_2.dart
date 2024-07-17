// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Local Storage Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  String _savedValue = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadSavedValue();
  }

  void _saveToLocalStorage() {
    final String value = _controller.text;
    html.window.localStorage['savedValue'] = value;
    setState(() {
      _savedValue = value;
    });
  }

  void _loadSavedValue() {
    setState(() {
      _savedValue = html.window.localStorage['savedValue'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Local Storage Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a value to save',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveToLocalStorage,
              child: const Text('Save to Local Storage'),
            ),
            const SizedBox(height: 20),
            Text(
              'Saved value: $_savedValue',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
