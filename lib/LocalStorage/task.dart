// task.dart
class Task {
  int? id;
  String name;
  bool isCompleted;

  Task({this.id, required this.name, this.isCompleted = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'is_completed': isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      isCompleted: map['is_completed'] == 1,
    );
  }
}
