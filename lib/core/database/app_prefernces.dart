import 'package:shared_preferences/shared_preferences.dart';

class AppPrefernces {
  static const String isFirstLogin = 'is_first_login';

  static Future<SharedPreferences> init() async {
    final preff = await SharedPreferences.getInstance();
    return preff;
  }

  static Future<bool> getIsFirstLogin() async {
    final preff = await init();
    return preff.getBool(isFirstLogin) ?? true;
  }

  static Future<void> setIsFirstLogin(bool value) async {
    final preff = await init();
    preff.setBool(isFirstLogin, value);
  }
}
