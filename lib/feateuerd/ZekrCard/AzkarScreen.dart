import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart'; // ← مشاركة

class MorningAzkarScreen extends StatefulWidget {
  @override
  _MorningAzkarScreenState createState() => _MorningAzkarScreenState();
}

class _MorningAzkarScreenState extends State<MorningAzkarScreen> {
  List<dynamic> azkarList = [];
  int currentIndex = 0;
  int currentRepeat = 0;
  bool isFinished = false;

  @override
  void initState() {
    super.initState();
    loadAzkar();
  }

  Future<void> loadAzkar() async {
    final String response = await rootBundle.loadString('assets/json/azkar_morning.json');
    final data = json.decode(response);
    setState(() {
      azkarList = data;
    });
  }

  void handleNextZekr() {
    if (currentIndex < azkarList.length - 1) {
      setState(() {
        currentIndex++;
        currentRepeat = 0;
      });
    } else {
      setState(() {
        isFinished = true;
      });
    }
  }

  void handleCounterTap() {
    final totalRepeat = azkarList[currentIndex]["repeat"];
    setState(() {
      if (currentRepeat < totalRepeat) {
        currentRepeat++;
      }
      if (currentRepeat >= totalRepeat) {
        handleNextZekr();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade400,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("أذكار الصباح", 
        style: TextStyle(color: Colors.white, 
        fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.nightlight_round),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: handleCounterTap, // ← أي ضغطة
        child: azkarList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : isFinished
                ? Center(
                    child: Text(
                      "✅ تم ذكر الله",
                      style: TextStyle(fontSize: 28, 
                      fontWeight: FontWeight.bold, color: 
                      Colors.deepPurple),
                    ),
                  )
                : Column(
                    children: [
                      // شريط التقدم
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 10,
                                  child: LinearProgressIndicator(
                                    value: (currentIndex + 1) / azkarList.length,
                                    backgroundColor: Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "${currentIndex + 1}/${azkarList.length}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),

                      SizedBox(height: 30),

                      // الذكر والفائدة
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(22),
                          child: Column(
                            children: [
                              Text(
                                azkarList[currentIndex]["text"],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'Amiri', 
                                fontSize: 22),
                              ),
                              SizedBox(height: 16),
                              Divider(
                                
                                thickness: 1.1, color: Colors.grey[400]),
                              SizedBox(height: 16),
                              Text(
                                azkarList[currentIndex]["benefits"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Amiri', fontSize: 20, color: Colors.deepPurple),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // العداد والنسخ والمشاركة
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.share, 
                              size: 33,
                              color: Colors.deepPurple),
                              onPressed: () {
                                final text = azkarList[currentIndex]["text"];
                                final benefits = azkarList[currentIndex]["benefits"];
                                Share.share('📿 $text\n\n📌 الفائدة: $benefits');
                              },
                            ),

                            // الدائرة
                            Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: CircularProgressIndicator(
                                        value: currentRepeat / azkarList[currentIndex]["repeat"],
                                        backgroundColor: Colors.grey[300],
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                                        strokeWidth: 7,
                                      ),
                                    ),
                                    Text(
                                      '$currentRepeat',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            IconButton(
                              icon: const Icon(Icons.copy, size: 33),
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: azkarList[currentIndex]["text"]));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('📋 تم نسخ الذكر')),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // زر التالي
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: handleNextZekr,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: EdgeInsets.symmetric(vertical: 11),
                            ),
                            child: Text(
                              "التالي",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
