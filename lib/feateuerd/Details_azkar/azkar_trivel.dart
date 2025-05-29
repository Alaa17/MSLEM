import 'package:flutter/material.dart';
import 'package:my_mslem/feateuerd/ZekrCard/AzkarScreen.dart'; // عدل المسار لو مختلف

class AzkarUp extends StatelessWidget {
  const AzkarUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AzkarScreen(
      jsonFilePath: 'assets/json/azkar_travel.json', // مسار ملف أذكار الصباح
      title: 'أذكار المسافر',
    );
  }
}

