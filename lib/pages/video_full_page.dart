import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'master_page.dart';
import '../utils/like_manager.dart';
import 'video_comment_page.dart';

class VideoFullPage extends StatefulWidget {
  final String videoPath;
  final Character character;

  const VideoFullPage({
    super.key,
    required this.videoPath,
    required this.character,
  });

  @override
  State<VideoFullPage> createState() => _VideoFullPageState();
}

class _VideoFullPageState extends State<VideoFullPage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isInitialized = false;
  bool _showControls = true;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.asset(widget.videoPath);
    await _controller.initialize();
    
    // 检查点赞状态
    final liked = await LikeManager.isLiked(widget.videoPath);
    
    setState(() {
      _isInitialized = true;
      _isPlaying = true;
      _isLiked = liked;
    });
    _controller.play();
    _controller.setLooping(true);

    // 自动隐藏控制按钮
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
        _showControls = true;
      } else {
        _controller.play();
        _isPlaying = true;
        // 3秒后自动隐藏控制按钮
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted && _isPlaying) {
            setState(() {
              _showControls = false;
            });
          }
        });
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
      if (_showControls) {
        // 3秒后自动隐藏
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _showControls = false;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            // 视频播放器
            if (_isInitialized)
              SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            else
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),

            // 控制按钮层
            if (_showControls)
              Stack(
                children: [
                  // 暂停/播放按钮（中间）
                  Center(
                    child: GestureDetector(
                      onTap: _togglePlayPause,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),

                  // 返回按钮（左上角）
                  Positioned(
                    top: MediaQuery.of(context).padding.top,
                    left: 0,
                    child: SafeArea(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 24,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ),

                  // 右下角交互按钮
                  Positioned(
                    right: 16,
                    bottom: 200,
                    child: SafeArea(
                      child: Column(
                        children: [
                          // 点赞按钮
                          GestureDetector(
                            onTap: () async {
                              final newLikeState = await LikeManager.toggleLike(widget.videoPath);
                              setState(() {
                                _isLiked = newLikeState;
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Image.asset(
                                _isLiked
                                    ? 'assets/icon_vedio_like_s.webp'
                                    : 'assets/icon_vedio_like_n.webp',
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // 评论按钮
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => VideoCommentPage(
                                  videoPath: widget.videoPath,
                                ),
                              );
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Image.asset(
                                'assets/icon_vedio_chat.webp',
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 底部用户信息
                  Positioned(
                    bottom: 60,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 用户头像
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.purple,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              widget.character.userIcon,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // 用户名
                        Text(
                          widget.character.nickName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // 音频提示
                        Text(
                          'Put on the headphones, and...',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 底部进度条
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _isInitialized
                        ? VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                              playedColor: Colors.white,
                              bufferedColor: Colors.white38,
                              backgroundColor: Colors.white24,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

}

