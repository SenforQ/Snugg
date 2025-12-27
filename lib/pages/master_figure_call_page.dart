import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'master_page.dart';

class MasterFigureCallPage extends StatefulWidget {
  final Character character;

  const MasterFigureCallPage({
    super.key,
    required this.character,
  });

  @override
  State<MasterFigureCallPage> createState() => _MasterFigureCallPageState();
}

class _MasterFigureCallPageState extends State<MasterFigureCallPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _autoHangupTimer;
  Timer? _durationTimer;
  int _callDuration = 0;
  bool _isMuted = false;
  bool _isVideoEnabled = true;
  bool _isFrontCamera = true;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _startCall();
  }

  Future<void> _startCall() async {
    // 播放背景音乐
    try {
      await _audioPlayer.play(AssetSource('snugg_music.mp3'));
      await _audioPlayer.setReleaseMode(ReleaseMode.loop); // 循环播放
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }

    // 30秒后自动挂断
    _autoHangupTimer = Timer(const Duration(seconds: 30), () {
      _hangup();
    });

    // 开始计时
    _startTimer();
  }

  void _startTimer() {
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _callDuration++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _hangup() async {
    if (_isDisposed) return;
    
    _autoHangupTimer?.cancel();
    _durationTimer?.cancel();
    
    try {
      await _audioPlayer.stop();
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }
    
    try {
      await _audioPlayer.dispose();
    } catch (e) {
      debugPrint('Error disposing audio: $e');
    }
    
    _isDisposed = true;
    
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    // TODO: 实现静音逻辑
  }

  void _toggleVideo() {
    setState(() {
      _isVideoEnabled = !_isVideoEnabled;
    });
    // TODO: 实现视频开关逻辑
  }

  void _switchCamera() {
    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
    // TODO: 实现切换摄像头逻辑
  }

  @override
  void dispose() {
    _autoHangupTimer?.cancel();
    _durationTimer?.cancel();
    
    if (!_isDisposed) {
      _isDisposed = true;
      
      // 异步清理音频播放器，但不等待完成
      _audioPlayer.stop().catchError((e) {
        debugPrint('Error stopping audio in dispose: $e');
      });
      
      _audioPlayer.dispose().catchError((e) {
        debugPrint('Error disposing audio in dispose: $e');
      });
    }
    
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    // 获取背景图片（ShowPhotoArray 第3张，索引2）
    final backgroundImage = widget.character.showPhotoArray.length > 2
        ? widget.character.showPhotoArray[2]
        : (widget.character.showPhotoArray.isNotEmpty
            ? widget.character.showPhotoArray[0]
            : 'assets/user_default.webp');

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 背景图片 - 全屏展示
          Positioned(
            top: 0,
            left: 0,
            width: screenWidth,
            height: screenHeight,
            child: Image.asset(
              backgroundImage,
              width: screenWidth,
              height: screenHeight,
              fit: BoxFit.cover,
            ),
          ),

          // 左侧控制按钮（视频、静音、切换摄像头）
          Positioned(
            left: 20,
            top: statusBarHeight + 60,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // 视频按钮
                  _buildControlButton(
                    icon: _isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                    onTap: _toggleVideo,
                  ),
                  const SizedBox(height: 20),
                  // 静音按钮
                  _buildControlButton(
                    icon: _isMuted ? Icons.mic_off : Icons.mic,
                    onTap: _toggleMute,
                  ),
                  const SizedBox(height: 20),
                  // 切换摄像头按钮
                  _buildControlButton(
                    icon: Icons.flip_camera_ios,
                    onTap: _switchCamera,
                  ),
                ],
              ),
            ),
          ),

          // 中间：角色信息（头像、昵称、通话时长）
          Positioned(
            top: screenHeight * 0.3,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // 角色头像
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      widget.character.userIcon,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // 角色昵称
                Text(
                  widget.character.nickName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // 通话状态和时长
                Text(
                  'Calling...${_formatDuration(_callDuration)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // 底部：挂断按钮（红色）
          Positioned(
            bottom: 40 + MediaQuery.of(context).padding.bottom,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _hangup,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}

