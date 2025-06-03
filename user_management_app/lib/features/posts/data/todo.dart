class Todo {
  final int id;
  final String todo;
  final bool completed;

  Todo({required this.id, required this.todo, required this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
    );
  }
}