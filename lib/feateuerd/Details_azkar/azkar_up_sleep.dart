import 'package:flutter/material.dart';
import 'package:my_mslem/feateuerd/ZekrCard/AzkarScreen.dart';

class AzkarInstHome extends StatelessWidget {
  const AzkarInstHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AzkarScreen(
      jsonFilePath: 'assets/json/azkar_up_sleep.json', 
      title: 'أذكار الاستيقاظ');
  }
}