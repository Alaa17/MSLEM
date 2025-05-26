import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:adhan_dart/adhan_dart.dart' as adhan;

class PrayerHeader extends StatefulWidget {
  const PrayerHeader({super.key});

  @override
  State<PrayerHeader> createState() => _PrayerHeaderState();
}

class _PrayerHeaderState extends State<PrayerHeader> {
  String currentTime = '';
  String currentLocation = '';
  String currentDay = '';
  String currentGregorianDate = '';
  String currentHijriDate = '';

  Map<String, DateTime>? prayerTimes;

  @override
  void initState() {
    super.initState();
    _fetchAll();
  }

  Future<void> _fetchAll() async {
    await fetchTimeAndLocation();
    await fetchPrayerTimes();
    _setCurrentDates();
  }

  void _setCurrentDates() {
    final now = DateTime.now();

    final weekdayArabic = DateFormat.EEEE('ar').format(now);
    final gregorian = DateFormat('dd MMMM yyyy', 'ar').format(now);
    final hijri = HijriCalendar.now();

    setState(() {
      currentDay = weekdayArabic;
      currentGregorianDate = gregorian;
      currentHijriDate = '${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} هـ';
    });
  }

  Future<void> fetchTimeAndLocation() async {
    try {
      final now = DateTime.now();
      setState(() {
        currentTime = formatTime12Hour(now);
      });

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) return;
      }

      Position position =
          await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      // 🛡️ حماية من تأخير شديد
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      ).timeout(const Duration(seconds: 4));

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          currentLocation = '${place.locality}, ${place.country}';
        });
      }
    } catch (e) {
      print('خطأ في تحديد الموقع أو العنوان: $e');
      setState(() {
        currentLocation = 'الموقع غير متاح';
      });
    }
  }

  Future<void> fetchPrayerTimes() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) return;
      }

      Position position =
          await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      final coordinates = adhan.Coordinates(position.latitude, position.longitude);

      final params = adhan.CalculationMethod.muslimWorldLeague();
      params.madhab = adhan.Madhab.shafi;

      final prayers = adhan.PrayerTimes(
        coordinates: coordinates,
        date: DateTime.now(),
        calculationParameters: params,
      );

      setState(() {
        prayerTimes = {
          'الفجر': prayers.fajr!,
          'الشروق': prayers.sunrise!,
          'الظهر': prayers.dhuhr!,
          'العصر': prayers.asr!,
          'المغرب': prayers.maghrib!,
          'العشاء': prayers.isha!,
        };
      });
    } catch (e) {
      print('Error fetching prayer times: $e');
    }
  }

  String formatTime12Hour(DateTime time) {
    int hour = time.hour;
    String period = 'ص';
    if (hour >= 12) {
      period = 'م';
      if (hour > 12) hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.green.shade700,
      Colors.orange.shade700,
      Colors.blue.shade700,
      Colors.red.shade700,
      Colors.purple.shade700,
      Colors.teal.shade700,
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            height: 300,
            'assets/images/ppp.png',
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Column(
              children: [
                // اليوم والتواريخ والموقع
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentDay,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          currentLocation.isNotEmpty
                              ? currentLocation
                              : 'جارٍ تحديد الموقع...',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          currentGregorianDate,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          currentHijriDate,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // أوقات الصلاة
                if (prayerTimes != null)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: prayerTimes!.entries.map((entry) {
                        int idx = prayerTimes!.keys.toList().indexOf(entry.key);
                        return Container(
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colors[idx],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                entry.key,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                formatTime12Hour(entry.value),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  )
                else
                  const Center(
                    child: Text(
                      'جاري تحميل أوقات الصلاة...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HijriCalendar {
  final int hDay;
  final String longMonthName;
  final int hYear;

  HijriCalendar._(this.hDay, this.longMonthName, this.hYear);

  factory HijriCalendar.now() {
    DateTime today = DateTime.now();
    int julianDay = (today.millisecondsSinceEpoch / 86400000).floor() + 2440588;
    int islamicDay = ((julianDay - 1948439.5) % 354).floor() + 1;
    int islamicMonth = (((julianDay - 1948439.5) / 29.5) % 12).floor() + 1;
    int islamicYear = (((julianDay - 1948439.5) / 354).floor()) + 1389;

    List<String> monthNames = [
      '',
      'محرم',
      'صفر',
      'ربيع الأول',
      'ربيع الثاني',
      'جمادى الأولى',
      'جمادى الآخرة',
      'رجب',
      'شعبان',
      'رمضان',
      'شوال',
      'ذو القعدة',
      'ذو الحجة'
    ];

    return HijriCalendar._(islamicDay, monthNames[islamicMonth], islamicYear);
  }
}
