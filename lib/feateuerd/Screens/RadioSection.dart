import 'dart:async';
import 'package:flutter/material.dart';

class RadioSection extends StatefulWidget {
  const RadioSection({super.key});

  @override
  State<RadioSection> createState() => _RadioSectionState();
}

class _RadioSectionState extends State<RadioSection> {
  int duration = 0; // مدة التشغيل بالدقائق
  int remainingTime = 0; // الوقت المتبقي بالثواني
  bool isPlaying = false;
  String selectedReader = "ماهر المعيقلي";
  Timer? _timer;

  void togglePlay() {
    if (duration == 0 && !isPlaying) return;

    setState(() {
      if (isPlaying) {
        // إيقاف المؤقت
        _timer?.cancel();
        isPlaying = false;
      } else {
        // بدء المؤقت
        remainingTime = duration * 60; // تحويل الدقائق إلى ثواني
        isPlaying = true;

        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (remainingTime > 0) {
            setState(() {
              remainingTime--;
            });
          } else {
            timer.cancel();
            setState(() {
              isPlaying = false;
            });
          }
        });
      }
    });
  }

  void _showReaderList() {
    List<String> readers = [
      'ماهر المعيقلي',
      'عبدالباسط عبدالصمد',
      'مشاري راشد',
      'سعد الغامدي',
      'ياسر الدوسري',
      'أحمد العجمي',
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ListView(
        children: readers.map((name) {
          return ListTile(
            title: Text(name, textAlign: TextAlign.center),
            onTap: () {
              setState(() {
                selectedReader = name;
              });
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.deepPurple.shade100,
              Colors.deepPurple.shade200,
            ],
          ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "إذاعة القرآن الكريم",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2C68),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // صف الأيقونات موزعة بالتساوي والأيقونة جنب النص
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.access_time, color: Color(0xFF2E2C68), size: 22),
                    SizedBox(width: 4),
                    Text(
                      "مدة التشغيل",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E2C68),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.headphones, color: Color(0xFF2E2C68), size: 22),
                    SizedBox(width: 4),
                    Text(
                      "الاستماع",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E2C68),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: _showReaderList,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.list, color: Color(0xFF2E2C68), size: 22),
                      SizedBox(width: 4),
                      Text(
                        "اختر القارئ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E2C68),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // الصف السفلي: المؤقت - التشغيل - القارئ
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _timerBox(),
              GestureDetector(
                onTap: togglePlay,
                child: _playButton(),
              ),
              _readerBox(selectedReader),
            ],
          ),

          if (isPlaying)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                "الوقت المتبقي: ${formatTime(remainingTime)}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _timerBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.deepPurple),
        color: const Color.fromARGB(255, 223, 218, 253),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (duration > 0) duration--;
              });
            },
            child: _iconButton(Icons.remove),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              Text(
                "$duration",
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const Text(
                "دقيقة",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                duration++;
              });
            },
            child: _iconButton(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 20, color: const Color(0xFF2E2C68)),
    );
  }

  Widget _playButton() {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF2E2C68),
      ),
      child: Icon(
        isPlaying ? Icons.pause : Icons.play_arrow,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  Widget _readerBox(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black),
        color: const Color.fromARGB(255, 224, 219, 247),
      ),
      child: Text(
        name,
        style: const TextStyle(
          color: Color(0xFF2E2C68),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
