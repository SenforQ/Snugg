import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/block_manager.dart';
import 'report_page.dart';
import 'master_figure_page.dart';
import 'master_chat_page.dart';
import 'image_full_page.dart';

class Character {
  final String nickName;
  final String userIcon;
  final String? workImage;
  final List<String> showPhotoArray;
  final List<String> showVideoArray;
  final List<String> showThumbnailArray;
  final String showMotto;
  final int showFollowNum;
  final int showLike;
  final String showSayhi;
  final String showBackground;

  Character({
    required this.nickName,
    required this.userIcon,
    this.workImage,
    required this.showPhotoArray,
    required this.showVideoArray,
    required this.showThumbnailArray,
    required this.showMotto,
    required this.showFollowNum,
    required this.showLike,
    required this.showSayhi,
    required this.showBackground,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      nickName: json['NickName'] ?? '',
      userIcon: json['UserIcon'] ?? '',
      workImage: json['WorkImage'],
      showPhotoArray: List<String>.from(json['ShowPhotoArray'] ?? []),
      showVideoArray: List<String>.from(json['ShowVideoArray'] ?? []),
      showThumbnailArray: List<String>.from(json['ShowThumbnailArray'] ?? []),
      showMotto: json['ShowMotto'] ?? '',
      showFollowNum: json['ShowFollowNum'] ?? 0,
      showLike: json['ShowLike'] ?? 0,
      showSayhi: json['ShowSayhi'] ?? '',
      showBackground: json['ShowBackground'] ?? '',
    );
  }
}

class MasterPage extends StatefulWidget {
  const MasterPage({super.key});

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  List<Character> _characters = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/characters_figure.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      // 获取拉黑和屏蔽列表
      final blockedList = await BlockManager.getBlockedList();
      final mutedList = await BlockManager.getMutedList();
      
      final List<Character> characters = jsonList
          .map((json) => Character.fromJson(json))
          .where((character) => character.workImage != null)
          .where((character) => !blockedList.contains(character.nickName))
          .where((character) => !mutedList.contains(character.nickName))
          .toList();

      setState(() {
        _characters = characters;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading characters: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomPadding = MediaQuery.of(context).padding.bottom + 12 + 89;

    return Scaffold(
      body: Stack(
        children: [
          // 背景图片
          Positioned(
            left: 0,
            top: 0,
            width: screenWidth,
            height: screenHeight,
            child: Image.asset(
              'assets/bg_home_nor.webp',
              width: screenWidth,
              height: screenHeight,
              fit: BoxFit.cover,
            ),
          ),
          // 可滚动内容
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 58),
                // 顶部标题图片
                Center(
                  child: Image.asset(
                    'assets/img_master_nor.webp',
                    width: 240,
                    height: 35,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                // 下方图片
                GestureDetector(
                  onTap: () {
                    // 跳转到聊天页面，使用第一个角色
                    if (_characters.isNotEmpty) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MasterChatPage(
                            character: _characters[0],
                          ),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset(
                      'assets/img_master_creativity.webp',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Recommend 区域
                _buildRecommendSection(screenWidth),
                SizedBox(height: bottomPadding),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendSection(double screenWidth) {
    if (_isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Recommend 标题
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            'Recommend',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        // 角色网格
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: _characters.length,
            itemBuilder: (context, index) {
              return _buildCharacterItem(_characters[index], screenWidth);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCharacterItem(Character character, double screenWidth) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          // bg_master_nor.webp 作为背景
          Image.asset(
            'assets/bg_master_nor.webp',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // WorkImage 叠加在上面，有10px边距
          Positioned(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final imageHeight = constraints.maxHeight;
                  return Stack(
                    children: [
                      // WorkImage
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ImageFullPage(
                                imagePath: character.workImage!,
                                title: character.nickName,
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          character.workImage!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // 下半部分渐变黑色遮罩，从图片高度的一半开始
                      Positioned(
                        left: 0,
                        right: 0,
                        top: imageHeight * 0.5,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 角色头像和昵称
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              // 角色头像
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MasterFigurePage(
                                        character: character,
                                      ),
                                    ),
                                  ).then((value) {
                                    // 如果返回 true，说明有拉黑或屏蔽操作，重新加载数据
                                    if (value == true) {
                                      _loadCharacters();
                                    }
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    character.userIcon,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // 角色昵称
                              Expanded(
                                child: Text(
                                  character.nickName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 举报按钮
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => _showActionSheet(context, character),
                          child: Container(
                            width: 33,
                            height: 33,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.error_outline,
                              color: Colors.black,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showActionSheet(BuildContext context, Character character) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildActionSheet(context, character),
    );
  }

  Widget _buildActionSheet(BuildContext context, Character character) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            // 操作选项组
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _buildActionSheetItem(
                    context,
                    'Report',
                    () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ReportPage(
                            characterName: character.nickName,
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(height: 1, color: Colors.grey[300]),
                  _buildActionSheetItem(
                    context,
                    'Block',
                    () async {
                      await BlockManager.addBlocked(character.nickName);
                      Navigator.of(context).pop();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      _loadCharacters();
                    },
                    isDestructive: true,
                  ),
                  Divider(height: 1, color: Colors.grey[300]),
                  _buildActionSheetItem(
                    context,
                    'Mute',
                    () async {
                      await BlockManager.addMuted(character.nickName);
                      Navigator.of(context).pop();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      _loadCharacters();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // 取消按钮
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(14),
              ),
              child: _buildActionSheetItem(
                context,
                'Cancel',
                () {
                  Navigator.of(context).pop();
                },
                isCancel: true,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
          ],
        ),
      ),
    );
  }

  Widget _buildActionSheetItem(
    BuildContext context,
    String title,
    VoidCallback onTap, {
    bool isDestructive = false,
    bool isCancel = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: isCancel ? FontWeight.w600 : FontWeight.normal,
              color: isDestructive
                  ? Colors.red
                  : isCancel
                      ? Colors.blue
                      : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

