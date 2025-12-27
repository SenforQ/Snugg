import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LikeManager {
  static const String _keyLikedVideos = 'liked_videos';

  // 获取点赞列表
  static Future<List<String>> getLikedVideos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyLikedVideos);
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

  // 检查是否已点赞
  static Future<bool> isLiked(String videoPath) async {
    final list = await getLikedVideos();
    return list.contains(videoPath);
  }

  // 切换点赞状态
  static Future<bool> toggleLike(String videoPath) async {
    final list = await getLikedVideos();
    if (list.contains(videoPath)) {
      list.remove(videoPath);
      await _saveLikedVideos(list);
      return false; // 取消点赞
    } else {
      list.add(videoPath);
      await _saveLikedVideos(list);
      return true; // 点赞
    }
  }

  // 保存点赞列表
  static Future<void> _saveLikedVideos(List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLikedVideos, json.encode(list));
  }
}

