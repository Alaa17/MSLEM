import 'package:flutter/material.dart';
import 'package:my_mslem/feateuerd/ZekrCard/AzkarScreen.dart'; // عدل المسار لو مختلف

class AzkarNithg extends StatelessWidget {
  const AzkarNithg({super.key});

  @override
  Widget build(BuildContext context) {
    return const AzkarScreen(
      jsonFilePath: 'assets/json/azkar_nethg.json', // مسار ملف أذكار الصباح
      title: 'أذكار المساء',
    );
  }
}
