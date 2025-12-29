import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/user_info_manager.dart';
import 'snugg_editor_page.dart';
import 'privacy_policy_page.dart';
import 'user_agreement_page.dart';
import 'about_us_page.dart';
import 'wallet_snugg_page.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  String? _avatarPath;
  String? _avatarRelativePath;
  String _nickname = 'Snugg';
  String _signature = 'No personal signature';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final nickname = await UserInfoManager.getNickname();
    final signature = await UserInfoManager.getSignature();
    final avatarRelativePath = await UserInfoManager.getAvatarPath();

    File? avatarFile;
    if (avatarRelativePath != null) {
      avatarFile = await UserInfoManager.getImageFile(avatarRelativePath);
    }

    setState(() {
      _nickname = nickname;
      _signature = signature;
      _avatarRelativePath = avatarRelativePath;
      _avatarPath = avatarFile?.path;
    });
  }

  void _onUserInfoUpdated(String? avatarPath, String nickname, String signature) {
    setState(() {
      _avatarPath = avatarPath;
      _nickname = nickname;
      _signature = signature;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A1A),
              Color(0xFF000000),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileSection(),
                _buildVipButton(),
                const SizedBox(height: 32),
                _buildMenuList(),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 12 + 89),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    Widget avatarWidget;
    if (_avatarPath != null && File(_avatarPath!).existsSync()) {
      avatarWidget = Image.file(
        File(_avatarPath!),
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      );
    } else {
      avatarWidget = Image.asset(
        'assets/user_default.webp',
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: avatarWidget,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _nickname,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _signature,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVipButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const WalletSnuggPage(),
            ),
          );
        },
        child: Image.asset(
          'assets/btn_me_vip.webp',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildMenuList() {
    final menuItems = [
      {
        'icon': 'assets/icon_me_user.webp',
        'title': 'Edit information',
      },
      {
        'icon': 'assets/icon_me_privacy.webp',
        'title': 'Privacy Policy',
      },
      {
        'icon': 'assets/icon_me_us.webp',
        'title': 'User Agreement',
      },
      {
        'icon': 'assets/icon_me_setting.webp',
        'title': 'About us',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: menuItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == menuItems.length - 1;
            return _buildMenuItem(
              iconPath: item['icon']!,
              title: item['title']!,
              showDivider: !isLast,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String iconPath,
    required String title,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          leading: Image.asset(
            iconPath,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Image.asset(
            'assets/icon_me_right.webp',
            width: 16,
            height: 16,
            fit: BoxFit.contain,
          ),
          onTap: () {
            if (title == 'Edit information') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SnuggEditorPage(
                    onSave: _onUserInfoUpdated,
                  ),
                ),
              ).then((_) {
                _loadUserInfo();
              });
            } else if (title == 'Privacy Policy') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyPage(),
                ),
              );
            } else if (title == 'User Agreement') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserAgreementPage(),
                ),
              );
            } else if (title == 'About us') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AboutUsPage(),
                ),
              );
            }
          },
        ),
        if (showDivider)
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFE5E5E5),
            indent: 56,
          ),
      ],
    );
  }
}
