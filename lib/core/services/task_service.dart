import 'package:dio/dio.dart';
import '../models/task_model.dart';

class TaskService {
  final Dio _dio = Dio();
  final String baseUrl = "https://jsonplaceholder.typicode.com/todos";

  // Fetch all tasks
  Future<List<Task>> fetchTasks() async {
    try {
      final response = await _dio.get(baseUrl);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Task.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching tasks: $e");
    }
    return [];
  }

  // Create a new task
  Future<Task?> createTask(Task task) async {
    try {
      final response = await _dio.post(baseUrl, data: task.toJson());
      if (response.statusCode == 201) {
        return Task.fromJson(response.data);
      }
    } catch (e) {
      print("Error creating task: $e");
    }
    return null;
  }

  // Update an existing task
  Future<bool> updateTask(Task task) async {
    try {
      final response = await _dio.put("$baseUrl/${task.id}", data: task.toJson());
      return response.statusCode == 200;
    } catch (e) {
      print("Error updating task: $e");
    }
    return false;
  }

  // Delete a task
  Future<bool> deleteTask(int id) async {
    try {
      final response = await _dio.delete("$baseUrl/$id");
      return response.statusCode == 200;
    } catch (e) {
      print("Error deleting task: $e");
    }
    return false;
  }
}
