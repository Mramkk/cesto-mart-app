import 'package:shared_preferences/shared_preferences.dart';

abstract class Auth {
  static Future<bool> saveToken({required String token}) async {
    bool status = false;
    final prefs = await SharedPreferences.getInstance();
    status = await prefs.setString("token", token);
    return status;
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return token.toString();
  }

  static Future<bool> deleteToken() async {
    bool status = false;
    final prefs = await SharedPreferences.getInstance();
    status = await prefs.remove("token");
    return status;
  }
}
