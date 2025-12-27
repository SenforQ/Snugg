import 'package:flutter/material.dart';
import 'home_page.dart';
import 'master_page.dart';
import 'ai_page.dart';
import 'me_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const MasterPage(),
    const AiPage(),
    const MePage(),
  ];

  final List<Map<String, String>> _tabItems = [
    {
      'normal': 'assets/icon_home_nor.webp',
      'selected': 'assets/icon_home_pre.webp',
    },
    {
      'normal': 'assets/icon_master_nor.webp',
      'selected': 'assets/icon_master_pre.webp',
    },
    {
      'normal': 'assets/icon_ai_nor.webp',
      'selected': 'assets/icon_ai_pre.webp',
    },
    {
      'normal': 'assets/icon_me_nor.webp',
      'selected': 'assets/icon_me_pre.webp',
    },
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom + 12 + 89;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildCustomTabBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTabBar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 89,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _tabItems.length,
              (index) => _buildTabItem(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(int index) {
    final isSelected = _currentIndex == index;
    final imagePath = isSelected
        ? _tabItems[index]['selected']!
        : _tabItems[index]['normal']!;

    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: SizedBox(
        width: 72,
        height: 89,
        child: Image.asset(
          imagePath,
          width: 72,
          height: 89,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

