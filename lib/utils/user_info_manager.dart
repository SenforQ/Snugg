import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoManager {
  static const String _keyAvatarPath = 'user_avatar_path';
  static const String _keyNickname = 'user_nickname';
  static const String _keySignature = 'user_signature';

  static Future<String?> getAvatarPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAvatarPath);
  }

  static Future<String> getNickname() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyNickname) ?? 'Snugg';
  }

  static Future<String> getSignature() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keySignature) ?? 'No personal signature';
  }

  static Future<void> saveAvatarPath(String relativePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAvatarPath, relativePath);
  }

  static Future<void> saveNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyNickname, nickname);
  }

  static Future<void> saveSignature(String signature) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keySignature, signature);
  }

  static Future<String> getDocumentsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final appDir = Directory('${directory.path}/snugg_user_data');
    if (!await appDir.exists()) {
      await appDir.create(recursive: true);
    }
    return appDir.path;
  }

  static Future<String> saveImageToSandbox(File imageFile) async {
    final appDir = await getDocumentsDirectory();
    final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedFile = await imageFile.copy('$appDir/$fileName');
    final directory = await getApplicationDocumentsDirectory();
    final relativePath = savedFile.path.replaceFirst(directory.path + '/', '');
    return relativePath;
  }

  static Future<File?> getImageFile(String relativePath) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$relativePath');
      if (await file.exists()) {
        return file;
      }
    } catch (e) {
      // File not found
    }
    return null;
  }
}

