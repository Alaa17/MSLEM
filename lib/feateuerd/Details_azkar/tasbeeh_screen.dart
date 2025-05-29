import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:my_mslem/feateuerd/ZekrCard/tasbeeh_drawer.dart';

class TasbeehWaveScreen extends StatefulWidget {
  @override
  _TasbeehWaveScreenState createState() => _TasbeehWaveScreenState();
}

class _TasbeehWaveScreenState extends State<TasbeehWaveScreen> {
  int counter = 33;
  double fillPercent = 0.0;
  int zikrIndex = 0;
  bool isSoundOn = true;
  bool isVibrationOn = true;

  final AudioPlayer player = AudioPlayer();

  final List<String> azkar = [
    'سبحان الله',
    'الحمد لله',
    'الله أكبر',
    'استغفر الله',
    'لا إله إلا الله',
    'استغفر الله واتوب اليه',
    'لا حول ولا قوة إلا بالله',
    
  ];

  Map<String, int> zikrCounts = {};

  @override
  void initState() {
    super.initState();
    _enableBackgroundExecution();
    for (var zikr in azkar) {
      zikrCounts[zikr] = 0;
    }
  }

  Future<void> _enableBackgroundExecution() async {
    var androidConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: "سبحة تعمل في الخلفية",
      notificationText: "يتم تشغيل سبحة التسبيح في الخلفية",
      notificationImportance: AndroidNotificationImportance.normal,
      notificationIcon: const AndroidResource(name: 'ic_launcher', defType: 'mipmap'),
    );

    bool initialized = await FlutterBackground.initialize(androidConfig: androidConfig);
    if (!initialized) return;

    await FlutterBackground.enableBackgroundExecution();
  }

  Future<void> _playSound() async {
    try {
      await player.play(AssetSource('sound/mixkit-fast-double-click-on-mouse-275.wav')); // تأكد إن الملف موجود في assets/sounds
    } catch (e) {
      print("خطأ في تشغيل الصوت: $e");
    }
  }

  void _doTasbeeh() {
    if (counter > 0) {
      if (isVibrationOn) HapticFeedback.mediumImpact();
      if (isSoundOn) _playSound();

      setState(() {
        counter--;
        fillPercent += 1 / 33;
        String currentZikr = azkar[zikrIndex];
        zikrCounts[currentZikr] = (zikrCounts[currentZikr] ?? 0) + 1;
      });
    } else {
      _nextZikr();
    }
  }

  void _nextZikr() {
    setState(() {
      zikrIndex = (zikrIndex + 1) % azkar.length;
      counter = 33;
      fillPercent = 0.0;
    });
  }

  void _resetCounter() {
    if (isVibrationOn) HapticFeedback.mediumImpact();
    setState(() {
      counter = 33;
      fillPercent = 0.0;
      String currentZikr = azkar[zikrIndex];
      zikrCounts[currentZikr] = 0;
    });
  }

  @override
  void dispose() {
    FlutterBackground.disableBackgroundExecution();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 15, 12, 49),
      drawer: TasbeehDrawer(
        zikrCounts: zikrCounts,
        onReset: _resetCounter,
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(221, 8, 4, 48),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 28, 4, 248), width: 1.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    azkar[zikrIndex],
                    style: GoogleFonts.amiri(
                      fontSize: 24,
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                          blurRadius: 5,
                          color: Color.fromARGB(255, 56, 14, 241),
                          offset: Offset(1, 1),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      
                      isVibrationOn ? Icons.vibration : Icons.phonelink_erase,
                      size: 32,
                      color: const Color.fromARGB(255, 249, 249, 252),
                    ),
                    onPressed: () {
                      setState(() {
                        isVibrationOn = !isVibrationOn;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      isSoundOn ? Icons.volume_up : Icons.volume_off,
                      size: 32,
                      color: const Color.fromARGB(255, 253, 253, 255),
                    ),
                    onPressed: () {
                      setState(() {
                        isSoundOn = !isSoundOn;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 48, 3, 248), width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${33 - counter}',
                style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'Digital',
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: _doTasbeeh,
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: LiquidCircularProgressIndicator(
                      value: fillPercent,
                      valueColor: const AlwaysStoppedAnimation(Color.fromARGB(255, 3, 179, 248)),
                      backgroundColor: Theme.of(context).focusColor,
                      borderColor: const Color.fromARGB(255, 56, 14, 241),
                      borderWidth: 3.0,
                      direction: Axis.vertical,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$counter',
                            style: const TextStyle(
                              fontSize: 28,
                              fontFamily: 'Digital',
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            azkar[zikrIndex],
                            style: GoogleFonts.amiri(
                              fontSize: 20,
                              color: Colors.white,
                              shadows: const [
                                Shadow(
                                  blurRadius: 4,
                                  color: Color.fromARGB(255, 77, 4, 248),
                                  offset: Offset(0, 1),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: FloatingActionButton(
                    heroTag: "resetButton",
                    mini: true,
                    backgroundColor: const Color.fromARGB(255, 43, 55, 214),
                    onPressed: _resetCounter,
                    child: const Text(
                      "تصفير",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _nextZikr,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 52, 52, 240),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: const Text(
                'التالي',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
