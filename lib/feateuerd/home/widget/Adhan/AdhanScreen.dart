/*import 'dart:async';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdhanScreen extends StatefulWidget {
  const AdhanScreen({super.key});

  @override
  State<AdhanScreen> createState() => _AdhanScreenState();
}

class _AdhanScreenState extends State<AdhanScreen> {
  late PrayerTimes prayerTimes;
  late Prayer nextPrayer;
  late DateTime nextPrayerTime;
  Duration remaining = Duration.zero;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _calculatePrayerTimes();
    _startCountdown();
  }

  void _calculatePrayerTimes() {
    final coordinates = Coordinates(21.3891, 39.8579); // مكة كمثال
    final date = DateComponents.from(DateTime.now());
    final params = CalculationMethod.muslim_world_league();

    prayerTimes = PrayerTimes(coordinates, date, params);
    nextPrayer = prayerTimes.nextPrayer();
    nextPrayerTime = prayerTimes.timeForPrayer(nextPrayer)!;
    _updateRemaining();
  }

  void _updateRemaining() {
    setState(() {
      remaining = nextPrayerTime.difference(DateTime.now());
    });
  }

  void _startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemaining();
      if (remaining.isNegative) {
        _calculatePrayerTimes(); // تحديث للصلوات الجديدة
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final h = twoDigits(duration.inHours);
    final m = twoDigits(duration.inMinutes.remainder(60));
    final s = twoDigits(duration.inSeconds.remainder(60));
    return "$h:$m:$s";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2F9),
      appBar: AppBar(
        title: const Text('شاشة المؤذن'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E2C68),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.notifications_active, size: 64, color: Colors.deepPurple),
              const SizedBox(height: 16),
              Text(
                'الصلاة القادمة: ${_getPrayerName(nextPrayer)}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'الوقت: ${DateFormat('hh:mm a').format(nextPrayerTime)}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                'الوقت المتبقي',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              Text(
                _formatDuration(remaining),
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPrayerName(Prayer prayer) {
    switch (prayer) {
      case Prayer.fajr:
        return 'الفجر';
      case Prayer.dhuhr:
        return 'الظهر';
      case Prayer.asr:
        return 'العصر';
      case Prayer.maghrib:
        return 'المغرب';
      case Prayer.isha:
        return 'العشاء';
      case Prayer.none:
        return 'لا صلاة الآن';
    }
  }
}
*/