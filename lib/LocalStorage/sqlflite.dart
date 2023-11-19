// main.dart
import 'package:flutter/material.dart';
import 'task.dart';
import 'database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _taskController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _refreshTaskList();
  }

  void _refreshTaskList() async {
    List<Task> tasks = await _databaseHelper.fetchTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  void _addTask() async {
    String taskName = _taskController.text.trim();
    if (taskName.isNotEmpty) {
      Task newTask = Task(name: taskName);
      await _databaseHelper.insertTask(newTask);
      _refreshTaskList();
      _taskController.clear();
    }
  }

  void _toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    await _databaseHelper.updateTask(task);
    _refreshTaskList();
  }

  void _deleteTask(int taskId) async {
    await _databaseHelper.deleteTask(taskId);
    _refreshTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQFlite Example'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _taskController,
            decoration: InputDecoration(
              hintText: 'Enter task',
            ),
          ),
          ElevatedButton(
            onPressed: _addTask,
            child: Text('Add Task'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                Task task = _tasks[index];
                return ListTile(
                  title: Text(task.name),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) => _toggleTaskCompletion(task),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTask(task.id!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
