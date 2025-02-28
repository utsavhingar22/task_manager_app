import 'package:flutter/material.dart';
import 'core/services/local_storage.dart';
import 'features/auth/login_screen.dart';
import 'features/tasks/task_list_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = LocalStorage.getUserToken() != null;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const TaskListScreen() : const LoginScreen(),
    );
  }
}
