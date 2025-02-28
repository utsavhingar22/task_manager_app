// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../../core/services/task_service.dart';
import '../../core/models/task_model.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TaskService _taskService = TaskService();

  late String _title;
  late bool _completed;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _title = widget.task.title;
    _completed = widget.task.completed;
  }

  Future<void> _updateTask() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isUpdating = true);

      // Haptic feedback for better user interaction
      HapticFeedback.mediumImpact();

      _formKey.currentState!.save();

      Task updatedTask = Task(
        id: widget.task.id,
        userId: widget.task.userId,
        title: _title,
        completed: _completed,
      );

      bool success = await _taskService.updateTask(updatedTask);

      setState(() => _isUpdating = false);

      if (success) {
        Navigator.pop(context, updatedTask);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to update task',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)], // Same gradient as TaskListScreen
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          "Edit Task",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Details",
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(
                  labelText: "Task Title",
                  labelStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                  prefixIcon: const Icon(Icons.edit, color: Colors.blueAccent),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
                validator: (value) => value!.isEmpty ? "Title is required" : null,
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mark as Completed",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Transform.scale(
                    scale: 1.1,
                    child: CupertinoSwitch(
                      value: _completed,
                      onChanged: (value) => setState(() => _completed = value),
                      activeColor: Colors.green,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isUpdating ? null : _updateTask,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: _isUpdating ? Colors.grey : Colors.deepPurple,
                    elevation: 2,
                  ),
                  child: _isUpdating
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    "Update Task",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
