import 'package:flutter/material.dart';

class MyAnimatedCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final Gradient defaultGradient;
  final Gradient pressedGradient;
  final VoidCallback? onTap;

  const MyAnimatedCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.defaultGradient,
    required this.pressedGradient,
    this.onTap,
  }) : super(key: key);

  @override
  State<MyAnimatedCard> createState() => _MyAnimatedCardState();
}

class _MyAnimatedCardState extends State<MyAnimatedCard> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: _isPressed ? widget.pressedGradient : widget.defaultGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: _isPressed ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Image.asset(
                widget.imagePath,
                
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Amiri',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// مثال لاستخدام الكارت داخل GridView:
final List<Map<String, dynamic>> cardsData = [
  {
    'title': 'الأذكار',
    'imagePath': 'assets/icons/azkar.png',
    'defaultGradient': const LinearGradient(
      colors: [Color(0xFF6D8EFF), Colors.white],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ),
    'pressedGradient': const LinearGradient(
      colors: [Color(0xFF3A5FCD), Color(0xFF9BB3FF)],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ),
  },
  {
    'title': 'الصلوات',
    'imagePath': 'assets/icons/prayer.png',
    'defaultGradient': const LinearGradient(
      colors: [Color(0xFFFDAC81), Colors.white],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ),
    'pressedGradient': const LinearGradient(
      colors: [Color(0xFFF76B1C), Color(0xFFFFD9B3)],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ),
  },
  // أضف باقي الكروت هنا بنفس الشكل
];

// داخل صفحة العرض:
class CardGridPage extends StatelessWidget {
  const CardGridPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بطاقات متدرجة')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: cardsData.length,
        itemBuilder: (context, index) {
          final card = cardsData[index];
          return MyAnimatedCard(
            title: card['title'],
            imagePath: card['imagePath'],
            defaultGradient: card['defaultGradient'],
            pressedGradient: card['pressedGradient'],
            onTap: () {
              print('تم الضغط على: ${card['title']}');
            },
          );
        },
      ),
    );
  }
}
