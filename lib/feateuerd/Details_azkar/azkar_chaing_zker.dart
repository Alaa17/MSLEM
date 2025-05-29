import 'package:flutter/material.dart';
import 'package:my_mslem/feateuerd/ZekrCard/AzkarScreen.dart'; // عدل المسار لو مختلف

class AzkarOutHome extends StatelessWidget {
  const AzkarOutHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const AzkarScreen(
      jsonFilePath: 'assets/json/prophets_duas.json', // مسار ملف أذكار الصباح
      title: 'أدعية الانبياء',
    );
  }
}
