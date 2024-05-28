import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:facialcheck/model/user.dart';

class EventPref {
  static Future<void> saveUser(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('user', jsonEncode(user));
  }

  static Future<User?> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('user');
    if (stringUser != null) {
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      return User.fromJson(mapUser);
    }
    return null;
  }

  static Future<void> clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
