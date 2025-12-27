import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BlockManager {
  static const String _keyBlockedList = 'blocked_characters';
  static const String _keyMutedList = 'muted_characters';

  // 获取拉黑列表
  static Future<List<String>> getBlockedList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyBlockedList);
    if (jsonString == null) {
      return [];
    }
    try {
      final List<dynamic> list = json.decode(jsonString);
      return list.cast<String>();
    } catch (e) {
      return [];
    }
  }

  // 获取屏蔽列表
  static Future<List<String>> getMutedList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyMutedList);
    if (jsonString == null) {
      return [];
    }
    try {
      final List<dynamic> list = json.decode(jsonString);
      return list.cast<String>();
    } catch (e) {
      return [];
    }
  }

  // 添加拉黑
  static Future<void> addBlocked(String nickName) async {
    final list = await getBlockedList();
    if (!list.contains(nickName)) {
      list.add(nickName);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyBlockedList, json.encode(list));
    }
  }

  // 添加屏蔽
  static Future<void> addMuted(String nickName) async {
    final list = await getMutedList();
    if (!list.contains(nickName)) {
      list.add(nickName);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyMutedList, json.encode(list));
    }
  }

  // 移除拉黑
  static Future<void> removeBlocked(String nickName) async {
    final list = await getBlockedList();
    list.remove(nickName);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyBlockedList, json.encode(list));
  }

  // 移除屏蔽
  static Future<void> removeMuted(String nickName) async {
    final list = await getMutedList();
    list.remove(nickName);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyMutedList, json.encode(list));
  }

  // 检查是否被拉黑
  static Future<bool> isBlocked(String nickName) async {
    final list = await getBlockedList();
    return list.contains(nickName);
  }

  // 检查是否被屏蔽
  static Future<bool> isMuted(String nickName) async {
    final list = await getMutedList();
    return list.contains(nickName);
  }
}

