import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class AzkarScreen extends StatefulWidget {
  final String jsonFilePath;
  final String title;

  const AzkarScreen({Key? key, required this.jsonFilePath, required this.title}) : super(key: key);

  @override
  _AzkarScreenState createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
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
    final String response = await rootBundle.loadString(widget.jsonFilePath);
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
        backgroundColor: const Color.fromARGB(255, 10, 6, 247),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: GoogleFonts.cairo(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: handleCounterTap,
        child: azkarList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : isFinished
                ? Center(
                    child: Text(
                      "✅ تم ذكر الله",
                      style: GoogleFonts.cairo(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
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
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "${currentIndex + 1}/${azkarList.length}",
                            style: GoogleFonts.cairo(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // الذكر والفائدة
                      // الذكر والفائدة
Expanded(
  child: SingleChildScrollView(
    padding: const EdgeInsets.all(22),
    child: Column(
      children: [
        if (azkarList[currentIndex]["isQuran"] == true) ...[
          Text(
            "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 6, 124, 10),
            ),
          ),
          const SizedBox(height: 20),
        ],
        Text(
          azkarList[currentIndex]["text"] ?? '',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 8),

        // عرض حقل "from" إذا موجود
        if (azkarList[currentIndex]["from"] != null) ...[
          Text(
            " ${azkarList[currentIndex]["from"]}",
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              color: Colors.black,
              fontSize: 17,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
        ] else
          const SizedBox(height: 16),

        Divider(thickness: 1.1, color: Colors.black),
        const SizedBox(height: 16),
        Text(
          azkarList[currentIndex]["benefits"] ?? '',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    ),
  ),
),


                      // العداد والمشاركة وعدد التكرار
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.share, size: 33, color: Color.fromARGB(255, 10, 6, 247)),
                              onPressed: () {
                                final text = azkarList[currentIndex]["text"] ?? '';
                                final benefits = azkarList[currentIndex]["benefits"] ?? '';
                                Share.share('📿 $text\n\n📌 الفائدة: $benefits');
                              },
                            ),
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
                                        valueColor: const AlwaysStoppedAnimation<Color>(
                                          Color.fromARGB(255, 10, 6, 247),
                                        ),
                                        strokeWidth: 7,
                                      ),
                                    ),
                                    Text(
                                      '$currentRepeat',
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // عدد التكرار بدل الأيقونة
                            Column(
                              children: [
                                Text(
                                  'عدد التكرار',
                                  style: GoogleFonts.cairo(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${azkarList[currentIndex]["repeat"]} مرات',
                                  style: GoogleFonts.cairo(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
                              backgroundColor: const Color.fromARGB(255, 10, 6, 247),
                              padding: const EdgeInsets.symmetric(vertical: 11),
                            ),
                            child: Text(
                              "التالي",
                              style: GoogleFonts.cairo(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
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
