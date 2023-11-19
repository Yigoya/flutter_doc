// main.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'person.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  await Hive.openBox('personsBox');
  runApp(MyApp());

  // Closing Hive when the app is shutting down
  await Hive.close();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late Box<Person> _personsBox;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _personsBox = Hive.box<Person>('personsBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Flutter Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addPerson();
              },
              child: Text('Add Person'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: _buildPersonList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonList() {
    return ListView.builder(
      itemCount: _personsBox.length,
      itemBuilder: (context, index) {
        final person = _personsBox.getAt(index);
        return ListTile(
          title: Text('${person?.name} (${person?.age})'),
        );
      },
    );
  }

  void _addPerson() {
    final name = _nameController.text.trim();
    final age = int.tryParse(_ageController.text.trim()) ?? 0;

    if (name.isNotEmpty && age > 0) {
      final newPerson = Person()
        ..name = name
        ..age = age;

      _personsBox.add(newPerson);

      _nameController.clear();
      _ageController.clear();

      // Force a rebuild to update the person list
      setState(() {});
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    Hive.close();
    super.dispose();
  }
}
