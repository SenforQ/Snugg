import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TattooChatPage extends StatefulWidget {
  const TattooChatPage({super.key});

  @override
  State<TattooChatPage> createState() => _TattooChatPageState();
}

class _TattooChatPageState extends State<TattooChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  bool _isAiGenerating = false;

  static const String _apiKey = '4eb10ed370464149a41bf683da014095.DyXYRzmGpKiBfxIU';
  static const String _apiUrl = 'https://open.bigmodel.cn/api/paas/v4/images/generations';

  static const List<String> _tattooPrompts = [
    'A beautiful traditional rose tattoo design with intricate details and shading, perfect for placement on the upper arm, approximately 6 to 8 inches in size, featuring deep red petals with green leaves, classic American traditional style with bold black outlines',
    'Japanese dragon tattoo in black and gray ink, flowing design ideal for a full sleeve on the arm, measuring about 10 to 12 inches in length, with detailed scales and traditional Japanese cloud patterns, dynamic movement and elegant curves',
    'Geometric mandala pattern tattoo with symmetrical elements and intricate linework, suitable for placement on the upper back or chest, size around 8 to 10 inches in diameter, featuring sacred geometry patterns with dotwork and fine lines',
    'Colorful butterfly tattoo with realistic wings and detailed patterns, perfect for the shoulder or upper arm area, approximately 5 to 7 inches in width, vibrant colors including blues, purples, and oranges with delicate antenna details',
    'Classic anchor tattoo with rope design, nautical theme perfect for the forearm or calf, size about 4 to 6 inches, traditional sailor style with bold black ink, rope wrapping around the anchor with realistic texture',
    'Feather tattoo with birds flying in the background, freedom symbol design ideal for the inner forearm or side rib area, measuring 6 to 8 inches in length, detailed feather texture with birds in silhouette, black and gray shading',
    'Lotus flower tattoo with water ripples and spiritual elements, perfect for placement on the back or thigh, approximately 7 to 9 inches in size, featuring pink and white petals with green leaves, water ripples below, spiritual and elegant design',
    'Tree of life tattoo with intricate roots and branches extending, ideal for a full back piece or large thigh design, size around 12 to 15 inches in height, detailed bark texture, leaves, and roots with nature elements integrated',
    'Compass rose tattoo with detailed markings and nautical elements, suitable for the chest or upper arm, approximately 6 to 8 inches in diameter, traditional compass design with cardinal directions, decorative border, and vintage style',
    'Phoenix rising from flames tattoo, mythical creature design perfect for a full back piece or large thigh area, measuring 10 to 12 inches in height, vibrant red and orange flames with detailed feathers, powerful and dynamic composition',
    'Wolf howling at moon tattoo with nature scene background, ideal for the upper arm or shoulder area, size about 8 to 10 inches in width, realistic wolf with detailed fur, full moon, and forest silhouette in black and gray',
    'Cherry blossom branch tattoo in Japanese style, perfect for placement along the arm or leg, measuring 8 to 12 inches in length, delicate pink flowers with branches, traditional Japanese aesthetic with subtle shading',
    'Hourglass tattoo with sand and time symbolism, suitable for the forearm or wrist area, approximately 4 to 6 inches in height, detailed hourglass design with flowing sand, clock elements, and philosophical meaning',
    'Mountain range tattoo with sun setting in the background, landscape design ideal for the forearm or calf, size around 6 to 8 inches in length, detailed mountain peaks with sun rays, nature scene with atmospheric perspective',
    'Elephant tattoo with intricate patterns and cultural designs, perfect for the upper arm or thigh, approximately 7 to 9 inches in size, detailed elephant with geometric patterns, traditional cultural elements, and rich textures',
    'Japanese wave tattoo with traditional style, ocean theme ideal for a half sleeve or large forearm piece, measuring 8 to 10 inches in length, dynamic wave movement with foam details, traditional Japanese art style',
    'Sun and moon together tattoo, celestial design perfect for the chest or upper back, size about 6 to 8 inches in diameter, sun on one side and moon on the other, stars and cosmic elements, balanced composition',
    'Lion head tattoo with detailed mane, powerful design suitable for the upper arm or shoulder, approximately 7 to 9 inches in width, realistic lion with flowing mane, intense eyes, and regal expression in black and gray',
    'Owl tattoo with detailed feathers and wisdom symbolism, ideal for placement on the upper arm or back, size around 6 to 8 inches, realistic owl with intricate feather details, large eyes, and perched pose, nature elements',
    'Elegant flower bouquet tattoo with ribbon, perfect for the thigh or side body area, measuring 8 to 10 inches in height, various flowers including roses, peonies, and daisies with decorative ribbon, colorful and feminine design',
  ];

  @override
  void initState() {
    super.initState();
    _sendWelcomeMessage();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendWelcomeMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _messages.add(ChatMessage(
          text: 'Hi! I\'m your AI tattoo artist assistant. I\'ve been designing tattoos for over 10 years, specializing in creating unique and meaningful designs. Tell me what kind of tattoo you\'d like, and I\'ll generate a design that can be placed on the perfect body part for you!',
          isUser: false,
        ));
      });
      _scrollToBottom();
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _messageController.clear();
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      final imageUrl = await _generateImage(text);
      setState(() {
        _messages.add(ChatMessage(imageUrl: imageUrl, isUser: false));
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: 'Sorry, I encountered an error: ${e.toString()}',
          isUser: false,
        ));
        _isLoading = false;
      });
    }

    _scrollToBottom();
  }

  String _buildTattooPrompt(String userPrompt) {
    return 'Professional tattoo design, $userPrompt, detailed tattoo artwork, suitable for placement on body parts like arm, back, chest, or leg, high quality tattoo style, black and color ink, realistic tattoo design, clean background, professional tattoo artist style';
  }

  Future<String> _generateImage(String userPrompt) async {
    final enhancedPrompt = _buildTattooPrompt(userPrompt);
    
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'cogview-3-flash',
        'prompt': enhancedPrompt,
        'n': 1,
        'size': '1024x1024',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null && data['data'].isNotEmpty) {
        final imageData = data['data'][0];
        if (imageData['url'] != null) {
          return imageData['url'];
        } else if (imageData['b64_json'] != null) {
          return 'data:image/png;base64,${imageData['b64_json']}';
        }
      }
      throw Exception('No image data in response');
    } else {
      throw Exception('API request failed: ${response.statusCode} - ${response.body}');
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _generateAiPrompt() async {
    if (_isAiGenerating) return;

    setState(() {
      _isAiGenerating = true;
    });

    await Future.delayed(const Duration(seconds: 3));

    final random = DateTime.now().millisecondsSinceEpoch % _tattooPrompts.length;
    final selectedPrompt = _tattooPrompts[random];

    setState(() {
      _messageController.text = selectedPrompt;
      _isAiGenerating = false;
    });
  }

  void _showImageFullScreen(String imageUrl) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: imageUrl.startsWith('data:image')
                    ? Image.memory(
                        base64Decode(imageUrl.split(',')[1]),
                        fit: BoxFit.contain,
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.error, color: Colors.red, size: 50),
                          );
                        },
                      ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF010100),
      appBar: AppBar(
        backgroundColor: const Color(0xFF010100),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Tattoo AI Chat',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length) {
                  return _buildLoadingMessage();
                }
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/tattoo_icon.webp',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Colors.white
                    : Colors.green,
                borderRadius: BorderRadius.circular(16),
              ),
              child: message.imageUrl != null
                  ? GestureDetector(
                      onTap: () => _showImageFullScreen(message.imageUrl!),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: message.imageUrl!.startsWith('data:image')
                            ? Image.memory(
                                base64Decode(message.imageUrl!.split(',')[1]),
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                message.imageUrl!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: Center(
                                      child: Icon(Icons.error, color: Colors.red),
                                    ),
                                  );
                                },
                              ),
                      ),
                    )
                  : Text(
                      message.text ?? '',
                      style: TextStyle(
                        color: message.isUser ? Colors.black : Colors.black,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/tattoo_icon.webp',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF010100)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
        top: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF010100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Unlimited Creativity',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _isAiGenerating ? null : _generateAiPrompt,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF010100),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: _isAiGenerating
                  ? const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(
                        'AI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF010100),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String? text;
  final String? imageUrl;
  final bool isUser;

  ChatMessage({
    this.text,
    this.imageUrl,
    required this.isUser,
  });
}

