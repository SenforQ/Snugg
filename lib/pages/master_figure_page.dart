import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'master_page.dart';
import 'image_full_page.dart';
import 'video_full_page.dart';
import 'master_figure_chat_page.dart';
import 'master_figure_call_page.dart';
import 'report_page.dart';
import '../utils/block_manager.dart';

class MasterFigurePage extends StatefulWidget {
  final Character character;

  const MasterFigurePage({
    super.key,
    required this.character,
  });

  @override
  State<MasterFigurePage> createState() => _MasterFigurePageState();
}

class _MasterFigurePageState extends State<MasterFigurePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFF010100),
      body: Stack(
        children: [
          // 背景图片 - ShowPhotoArray 第2张（索引1），带模糊效果
          Positioned(
            top: 0,
            left: 0,
            width: screenWidth,
            height: 200,
            child: ClipRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Image.asset(
                  widget.character.showPhotoArray.length > 1
                      ? widget.character.showPhotoArray[1]
                      : widget.character.showPhotoArray[0],
                  width: screenWidth,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // 角色信息区域 - 固定在顶部
          Positioned(
            top: statusBarHeight + 200 - 120, // 稍微向上偏移，让白色区域部分覆盖背景
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    // 角色头像 - 带黑色圆形边框
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          widget.character.userIcon,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // 昵称和座右铭 - 黑色文字
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.character.nickName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.character.showMotto,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Call 和 Chat 按钮
                    Row(
                      children: [
                        // Call 按钮
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MasterFigureCallPage(
                                  character: widget.character,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Chat 按钮
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MasterFigureChatPage(
                                  character: widget.character,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 内容区域 - 可滚动，从固定头部下方开始
          Positioned(
            top: statusBarHeight + 200 + 60, // 背景高度 + 固定头部高度
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo 区域
                  _buildSection(
                    context,
                    'Photo',
                    widget.character.showPhotoArray,
                    isPhoto: true,
                  ),
                  // Video 区域
                  _buildSection(
                    context,
                    'Video',
                    widget.character.showVideoArray,
                    isPhoto: false,
                    thumbnails: widget.character.showThumbnailArray,
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 12 + 89),
                ],
              ),
            ),
          ),
          // 返回按钮
          Positioned(
            top: statusBarHeight,
            left: 0,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          // 举报按钮（右上角）
          Positioned(
            top: statusBarHeight,
            right: 0,
            child: SafeArea(
              child: IconButton(
                icon: Container(
                  width: 33,
                  height: 33,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                onPressed: () => _showActionSheet(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<String> items, {
    bool isPhoto = true,
    List<String>? thumbnails,
  }) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // 改为上下滑动的GridView
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isPhoto ? 1.0 : 0.8,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final imagePath = isPhoto
                  ? items[index]
                  : (thumbnails != null && index < thumbnails.length
                      ? thumbnails[index]
                      : items[index]);

              return GestureDetector(
                onTap: () {
                  if (isPhoto) {
                    // Photo: 跳转到全屏图片页面
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ImageFullPage(
                          imagePath: items[index],
                          title: title,
                        ),
                      ),
                    );
                  } else {
                    // Video: 跳转到全屏视频页面
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => VideoFullPage(
                          videoPath: items[index],
                          character: widget.character,
                        ),
                      ),
                    );
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Image.asset(
                        imagePath,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      if (!isPhoto)
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Options',
          style: TextStyle(fontSize: 13),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReportPage(
                    characterName: widget.character.nickName,
                  ),
                ),
              );
            },
            child: const Text('Report'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.of(context).pop(); // 关闭 ActionSheet
              await BlockManager.addBlocked(widget.character.nickName);
              // 返回上一页并通知重新加载数据
              if (context.mounted) {
                Navigator.of(context).pop(true);
              }
            },
            child: const Text('Block'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.of(context).pop(); // 关闭 ActionSheet
              await BlockManager.addMuted(widget.character.nickName);
              // 返回上一页并通知重新加载数据
              if (context.mounted) {
                Navigator.of(context).pop(true);
              }
            },
            child: const Text('Mute'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}

