import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'core/services/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // ✅ Ensure Hive is initialized
  await LocalStorage.init();
  runApp(TaskManagerApp());
}
