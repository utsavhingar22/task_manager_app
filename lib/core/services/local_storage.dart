import 'package:hive/hive.dart';

class LocalStorage {
  static late Box _box;

  static Future<void> init() async {
    _box = await Hive.openBox('userBox');
  }

  static Future<void> saveUserToken(String token) async {
    await _box.put('userToken', token);
  }

  static String? getUserToken() {
    return _box.get('userToken');
  }

  static Future<void> clearUserData() async { // ✅ Add this function
    await _box.clear();
  }
}
