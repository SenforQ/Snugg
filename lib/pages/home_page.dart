import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_ai.dart';
import 'word_post_page.dart';
import 'master_page.dart';
import 'master_figure_page.dart';
import '../utils/block_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Character> _characters = [];
  bool _isLoading = true;
  Set<String> _blockedSet = {};
  Set<String> _mutedSet = {};

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
          .toList();

      // 按照 ShowLike 从高到低排序
      characters.sort((a, b) => b.showLike.compareTo(a.showLike));

      setState(() {
        _characters = characters;
        _blockedSet = blockedList.toSet();
        _mutedSet = mutedList.toSet();
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading characters: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // 背景图片 - 固定不动
          Positioned.fill(
            child: Image.asset(
              'assets/bg_home_nor.webp',
              fit: BoxFit.cover,
            ),
          ),
          // 可滚动内容
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 顶部标题图片
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 66,
                  ),
                  child: Image.asset(
                    'assets/img_home_world.webp',
                    width: 222,
                    height: 35,
                    fit: BoxFit.contain,
                  ),
                ),
                // 下方图片 - 可点击跳转
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomeAiPage(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/bg_home_care.webp',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                // Tatto Rank 文字和添加按钮
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tatto Rank',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const WordPostPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Rank 列表
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Column(
                          children: List.generate(
                            _characters.length,
                            (index) {
                              final character = _characters[index];
                              return _buildRankCell(character, index + 1);
                            },
                          ),
                        ),
                ),
                // 底部间距
                const SizedBox(height: 100),
                
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankCell(Character character, int rank) {
    // 检查是否被拉黑或屏蔽
    final isBlocked = _blockedSet.contains(character.nickName);
    final isMuted = _mutedSet.contains(character.nickName);
    final isBlockedOrMuted = isBlocked || isMuted;
    
    return GestureDetector(
      onTap: isBlockedOrMuted
          ? () {
              // 显示提示信息
              String message;
              if (isBlocked) {
                message = 'This user has been blocked by you, so you cannot access their profile.';
              } else {
                message = 'This user has been muted by you, so you cannot access their profile.';
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.black87,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          : () {
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
      child: Opacity(
        opacity: isBlockedOrMuted ? 0.5 : 1.0, // 被拉黑或屏蔽的角色降低透明度
        child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
        children: [
          // 排名
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(
              '#$rank',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 头像
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              character.userIcon,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          // 昵称
          Expanded(
            child: Text(
              character.nickName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // ShowLike
          Row(
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                '${character.showLike}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
        ),
      ),
    );
  }
}

