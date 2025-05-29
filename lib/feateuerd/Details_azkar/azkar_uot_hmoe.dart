import 'package:flutter/material.dart';
import 'package:my_mslem/feateuerd/ZekrCard/AzkarScreen.dart'; // عدل المسار لو مختلف

class AzkarSlwat extends StatelessWidget {
  const AzkarSlwat({super.key});

  @override
  Widget build(BuildContext context) {
    return const AzkarScreen(
      jsonFilePath: 'assets/json/repentance_azkar.json', // مسار ملف أذكار الصباح
      title: 'أذكار الاستغفار',
    );
  }
}


