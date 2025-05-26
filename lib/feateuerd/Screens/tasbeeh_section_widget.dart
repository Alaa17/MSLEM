import 'package:flutter/material.dart';
import 'dart:math';

class TasbeehSection extends StatefulWidget {
  const TasbeehSection({super.key});

  @override
  State<TasbeehSection> createState() => _TasbeehSectionState();
}

class _TasbeehSectionState extends State<TasbeehSection> with TickerProviderStateMixin {
  int count = 0;
  int maxCount = 3;
  int currentZikrIndex = 0;
  bool isCompleted = false;

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _rotationController;

  List<Map<String, dynamic>> azkar = [
    {'text': 'اللّٰهُ أَكْبَر', 'color': Colors.pink},
    {'text': 'سُبْحَانَ اللّٰه', 'color': Colors.purple},
    {'text': 'الْحَمْدُ لِلّٰه', 'color': Colors.blue},
  ];

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
      lowerBound: 0.9,
      upperBound: 1.0,
    );
    _scaleAnimation = CurvedAnimation(parent: _scaleController, curve: Curves.easeOut);
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  void handleTap() async {
    await _scaleController.forward();
    await _scaleController.reverse();

    setState(() {
      count++;
    });

    if (count >= maxCount) {
      await _rotationController.forward(from: 0.0);
      setState(() {
        count = 0;
        currentZikrIndex++;
        if (currentZikrIndex >= azkar.length) {
          isCompleted = true;
        }
      });
    }
  }

  void resetTasbeeh() {
    setState(() {
      count = 0;
      currentZikrIndex = 0;
      isCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentZikr = azkar[currentZikrIndex % azkar.length]['text'];
    Color currentColor = azkar[currentZikrIndex % azkar.length]['color'];

    return SingleChildScrollView(
      child: Column(
        children: [
          // الصورة الثابتة فوق كارت التسبيح
    // الصورة الثابتة فوق كارت التسبيح





          // الكارت الرئيسي للتسبيح
          Card(
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 10,
            shadowColor: currentColor,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: isCompleted
                  ? Column(
                      children: [
                        Text(
                          "تم بحمد الله",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.purple,
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: resetTasbeeh,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              "إعادة التسبيح",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'حلقة التسبيح',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF18BB1E),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: azkar.map((z) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  child: Container(
                                    width: 120,
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: z['color'],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        z['text'],
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            GestureDetector(
                              onTap: handleTap,
                              child: ScaleTransition(
                                scale: _scaleAnimation,
                                child: RotationTransition(
                                  turns: _rotationController,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: CustomPaint(
                                          painter: SegmentPainter(
                                            progress: count.toDouble(),
                                            total: maxCount.toDouble(),
                                            color: currentColor,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          currentZikr,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                            color: currentColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
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

class SegmentPainter extends CustomPainter {
  final double progress;
  final double total;
  final Color color;

  SegmentPainter({required this.progress, required this.total, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi / total;

    Rect rect = Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2);

    for (int i = 0; i < total; i++) {
      canvas.drawArc(rect, startAngle + (sweepAngle * i), sweepAngle * 0.8, false, basePaint);
    }

    for (int i = 0; i < progress; i++) {
      canvas.drawArc(rect, startAngle + (sweepAngle * i), sweepAngle * 0.8, false, progressPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
