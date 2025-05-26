import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:my_mslem/feateuerd/Screens/floting_bottom.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late AnimationController _controller;
  late Animation<double> _animationScale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    );

    _animationScale = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    _playSound();

    // ننتقل بعد 8 ثواني إلى الصفحة الرئيسية
    Future.delayed(const Duration(seconds: 8), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const FlotingBottom()),
      );
    });
  }

  Future<void> _playSound() async {
    try {
      await _audioPlayer.setSource(AssetSource('sound/splash_sound.mp3'));
      await _audioPlayer.resume();
    } catch (e) {
      print("❌ خطأ أثناء تشغيل الصوت: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationScale,
        builder: (context, child) {
          return Transform.scale(
            scale: _animationScale.value,
            child: child,
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/msg.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
