import 'package:flutter/material.dart';
import 'package:my_mslem/feateuerd/Screens/PrayerHeader.dart';
import 'package:my_mslem/feateuerd/Screens/RadioSection.dart';
import 'package:my_mslem/feateuerd/Screens/salawat_rsol.dart';
import 'package:my_mslem/feateuerd/Screens/tasbeeh_section_widget.dart';
import 'package:my_mslem/feateuerd/home/HadithCard/hadith_card.dart';
import 'package:my_mslem/feateuerd/home/widget/card_view.dart' show MyAnimatedCard;

class Moazenpage extends StatelessWidget {
  const Moazenpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9ce3eb),
      body: SingleChildScrollView( // ✅ للسماح بالتمرير في حال تعدد المحتوى
        child: Column(
          children: [
           

            // كارت 
            PrayerHeader(),
            RadioSection(),
            TasbeehSection(),
            SalawatCard(),
            HadithCard(),
           
           
            

            // كارت لصفحة أخرى
         //   AnotherScreenCard(), // 👈 كارت ثاني

            // كارت ثالث مثلاً
            
          ],
        ),
      ),
    );
  }
}
