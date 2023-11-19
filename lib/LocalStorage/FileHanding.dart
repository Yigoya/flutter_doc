import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

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

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<void> writeToFile(String data) async {
  final path = await _localPath;
  print(path);
  final file = File('$path/your_file.txt');
  await file.writeAsString(data);
}

Future<String> readFromFile() async {
  try {
    final path = await _localPath;
    final file = File('$path/your_file.txt');
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return 'Error reading file: $e';
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Handling Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                writeToFile('Hello, this is some data to write to the file.');
              },
              child: const Text('Write to File'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String content = await readFromFile();
                print('File Content: $content');
              },
              child: const Text('Read from File'),
            ),
          ],
        ),
      ),
    );
  }
}
