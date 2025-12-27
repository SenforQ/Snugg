import 'dart:ui';
import 'package:flutter/material.dart';
import 'tattoo_chat_page.dart';

class AiPage extends StatelessWidget {
  const AiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final tabBarHeight = 89.0;
    final tabBarBottomPadding = 12.0;
    final viewHeight = 187.0;
    final viewBottomOffset = bottomPadding + tabBarBottomPadding + tabBarHeight;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            width: screenWidth,
            child: Image.asset(
              'assets/bg_ai_nor.webp',
              width: screenWidth,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: viewBottomOffset,
            height: viewHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'I\'m a tattoo AI assistant. I can answer all your questions about tattoos.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TattooChatPage(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/btn_ai_chat.webp',
                            width: 186,
                            height: 48,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

