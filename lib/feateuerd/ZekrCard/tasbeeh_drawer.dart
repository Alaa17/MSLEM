import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TasbeehDrawer extends StatelessWidget {
  final Map<String, int> zikrCounts;
  final VoidCallback? onAddTasbeeh;
  final VoidCallback? onReset;

  const TasbeehDrawer({
    Key? key,
    required this.zikrCounts,
    this.onAddTasbeeh,
    this.onReset, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // حساب المجموع الكلي لكل الأذكار
    int totalCount = zikrCounts.values.fold(0, (sum, item) => sum + item);

    return Drawer(
      backgroundColor: const Color.fromARGB(221, 15, 12, 49),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 243, 245),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onAddTasbeeh,
                icon: const Icon(Icons.add,
                size: 22,
                color: Color.fromARGB(255, 250, 188, 1),),
                label: const Text(
                  
                  "إضافة سبحة",
                  style: TextStyle(
color: Color.fromARGB(255, 252, 189, 1),
                    fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 38, 19, 124),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // نص يوضح أن هذا هو المجموع الكلي
                   Text(
                    "المجموع الكلي للتسبيحات",
                    style: GoogleFonts.cairo(
                    fontSize: 20,
                    color: Colors.white,
                  )),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          value: totalCount / (33 * zikrCounts.length),
                          strokeWidth: 8,
                          backgroundColor: Colors.white,
                          valueColor: const AlwaysStoppedAnimation(Color.fromARGB(255, 7, 3, 248)),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "${((totalCount / (33 * zikrCounts.length)) * 100).toStringAsFixed(0)}%",
                            style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 5, 140, 250)),
                          ),
                          Text(
                            "$totalCount",
                            style: const TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 6, 154, 190),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "عدد الأذكار: ${zikrCounts.length}",
                    style: GoogleFonts.cairo(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                 GestureDetector(
  onTap: onReset, // ✅ نربطه بالدالة
  child: Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 6, 154, 190),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      "تصفير العداد",
      style: GoogleFonts.cairo(
        fontSize: 17,
        color: Colors.white,
      ),
    ),
  ),
)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
