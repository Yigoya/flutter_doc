import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  String _storedName = '';

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedName = prefs.getString('userName') ?? '';
    });
  }

  Future<void> _saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Enter your name'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String enteredName = _nameController.text.trim();
                _saveName(enteredName);
                _loadName();
              },
              child: const Text('Save Name'),
            ),
            const SizedBox(height: 16.0),
            Text('Stored Name: $_storedName'),
          ],
        ),
      ),
    );
  }
}
