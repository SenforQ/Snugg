import 'package:shared_preferences/shared_preferences.dart';

class AgreementManager {
  static const String _keyAgreed = 'has_agreed_to_terms';

  // 检查是否已同意协议
  static Future<bool> hasAgreed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyAgreed) ?? false;
  }

  // 设置同意状态
  static Future<void> setAgreed(bool agreed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAgreed, agreed);
  }
}

