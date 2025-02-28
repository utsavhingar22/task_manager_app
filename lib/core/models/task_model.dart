class Task {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  // Factory method to create a Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  // Convert Task to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'completed': completed,
    };
  }
}
