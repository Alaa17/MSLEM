import 'package:flutter/material.dart';
import 'package:my_mslem/feateuerd/ZekrCard/AzkarScreen.dart';

class AzkarSleep extends StatelessWidget {
  const AzkarSleep({super.key});

  @override
  Widget build(BuildContext context) {
    return  AzkarScreen(
      jsonFilePath: 'assets/json/azkar_sleep.json', 
      title: 'أذكار النوم',
      );
  }
}