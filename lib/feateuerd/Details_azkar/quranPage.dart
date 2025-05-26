import 'dart:convert'; // للـ jsonDecode
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:my_mslem/feateuerd/ZekrCard/AzkarScreen.dart';
// تأكد من مسار الاستيراد الصحيح عندك

class AKARMORNING extends StatefulWidget {
  const AKARMORNING({Key? key}) : super(key: key);

  @override
  State<AKARMORNING> createState() => _AKARMORNINGState();
}

class _AKARMORNINGState extends State<AKARMORNING> {
  List<Map<String, dynamic>> morningAzkar = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadAzkarFromAssets();
  }

  Future<void> loadAzkarFromAssets() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/json/azkar_morning.json');
      final List<dynamic> jsonResponse = jsonDecode(jsonString);
      setState(() {
        morningAzkar = jsonResponse.map((e) => Map<String, dynamic>.from(e)).toList();
        isLoading = false;
      });
      print('✅ Loaded azkar count: ${morningAzkar.length}');
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'حدث خطأ أثناء تحميل الأذكار.';
      });
      debugPrint('❌ Error loading azkar json: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        
        appBar: AppBar(title: const Text('أذكار الصباح')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('أذكار الصباح')),
        body: Center(child: Text(errorMessage!, style: const TextStyle(fontSize: 18, color: Colors.red))),
      );
    }

    if (morningAzkar.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('أذكار الصباح')),
        body: const Center(child: Text('لا توجد أذكار لعرضها')),
      );
    }

    // عرض شاشة الأذكار مع تمرير البيانات
    return MorningAzkarScreen();
  }
}
