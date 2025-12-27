import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'roro_terms_page.dart';
import 'roro_privacy_page.dart';
import 'main_page.dart';
import '../utils/agreement_manager.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _isAgreed = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _enterApp() async {
    if (!_isAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms of Service and Privacy Policy'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    await AgreementManager.setAgreed(true);
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Stack(
        children: [
          // 背景图片
          Positioned.fill(
            child: Image.asset(
              'assets/welcome_content_bg.webp',
              fit: BoxFit.cover,
            ),
          ),
          // 底部内容区域
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomPadding + 48,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Enter App 按钮（在协议上方）
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFECFF80),
                          Color(0xFFB5FFD7),
                          Color(0xFFB1DBFF),
                          Color(0xFFF1C7FF),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: ElevatedButton(
                      onPressed: _enterApp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        'Enter App',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 协议文字和复选框（在底部安全边距 + 48 的位置）
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isAgreed = !_isAgreed;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 2),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: _isAgreed ? Colors.white : Colors.transparent,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: _isAgreed
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.black,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            children: [
                              const TextSpan(text: 'I have read and agree '),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const RoroTermsPage(),
                                      ),
                                    );
                                  },
                                text: 'Terms of Service',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const RoroPrivacyPage(),
                                      ),
                                    );
                                  },
                                text: 'Privacy Policy',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

