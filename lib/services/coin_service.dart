import 'package:shared_preferences/shared_preferences.dart';

class CoinService {
  static const String _keyCoins = 'user_coins';
  
  // 功能使用所需的硬币数量
  static const int tattooDailyCareCoins = 10;
  static const int tattooCreativityCoins = 30;

  static Future<void> initializeNewUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_keyCoins)) {
      await prefs.setInt(_keyCoins, 0);
    }
  }

  static Future<int> getCurrentCoins() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyCoins) ?? 0;
  }

  static Future<bool> addCoins(int coins) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentCoins = prefs.getInt(_keyCoins) ?? 0;
      await prefs.setInt(_keyCoins, currentCoins + coins);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deductCoins(int coins) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentCoins = prefs.getInt(_keyCoins) ?? 0;
      if (currentCoins >= coins) {
        await prefs.setInt(_keyCoins, currentCoins - coins);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

