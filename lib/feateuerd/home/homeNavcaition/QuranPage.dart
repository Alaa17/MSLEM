import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Quranpage extends StatelessWidget {
  const Quranpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(),
     body: Container(
       child: Text(
         'اللهم اجعل هذا اليوم بداية لكل خير، ونهاية لكل حزن 🌸',
         style: GoogleFonts.amiri(
           fontSize: 22,
           height: 1.8,
           fontWeight: FontWeight.w600,
         ),
         textAlign: TextAlign.center,
       ),
       
     ),

      
    );
  }
}