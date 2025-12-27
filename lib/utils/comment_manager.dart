import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Comment {
  final String id;
  final String content;
  final DateTime timestamp;
  final String? userAvatarPath;
  final String userName;
  final bool isCurrentUser;

  Comment({
    required this.id,
    required this.content,
    required this.timestamp,
    this.userAvatarPath,
    required this.userName,
    required this.isCurrentUser,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'userAvatarPath': userAvatarPath,
      'userName': userName,
      'isCurrentUser': isCurrentUser,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      userAvatarPath: json['userAvatarPath'],
      userName: json['userName'] ?? 'User',
      isCurrentUser: json['isCurrentUser'] ?? false,
    );
  }
}

class CommentManager {
  static const String _keyComments = 'video_comments';

  // 获取某个视频的评论列表
  static Future<List<Comment>> getComments(String videoPath) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('$_keyComments:$videoPath');
    if (jsonString == null) {
      return [];
    }
    try {
      final List<dynamic> list = json.decode(jsonString);
      return list.map((json) => Comment.fromJson(json)).toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp)); // 按时间倒序
    } catch (e) {
      return [];
    }
  }

  // 添加评论
  static Future<void> addComment(
    String videoPath,
    String content,
    String? userAvatarPath,
    String userName,
  ) async {
    final comments = await getComments(videoPath);
    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      timestamp: DateTime.now(),
      userAvatarPath: userAvatarPath,
      userName: userName,
      isCurrentUser: true,
    );
    comments.add(newComment);
    await _saveComments(videoPath, comments);
  }

  // 删除评论
  static Future<void> deleteComment(String videoPath, String commentId) async {
    final comments = await getComments(videoPath);
    comments.removeWhere((comment) => comment.id == commentId);
    await _saveComments(videoPath, comments);
  }

  // 保存评论列表
  static Future<void> _saveComments(String videoPath, List<Comment> comments) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = comments.map((comment) => comment.toJson()).toList();
    await prefs.setString('$_keyComments:$videoPath', json.encode(jsonList));
  }
}

