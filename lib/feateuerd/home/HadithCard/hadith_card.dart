import 'package:flutter/material.dart';

class HadithCard extends StatelessWidget {
const HadithCard({super.key});

@override
Widget build(BuildContext context) {
return Center(
child: Stack(
clipBehavior: Clip.none,
children: [
Container(
margin: const EdgeInsets.only(top: 40),
padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
decoration: BoxDecoration(
color: const Color.fromARGB(255, 245, 235, 203), // نفس لون الخلفية
borderRadius: BorderRadius.circular(16),
border: Border.all(color:  Colors.deepPurple),
),
width: MediaQuery.of(context).size.width * 0.85,
child: Column(
children: [
const SizedBox(height: 40), // مساحة الأيقونة العلوية
const Text(
'أحاديث',
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
color: Color(0xFF6C5B2E), // نفس لون العنوان
),
),
const SizedBox(height: 16),
const Text(
'قال رسول الله ﷺ: من سلك طريقًا يلتمس فيه علمًا، سهّل الله له به طريقًا إلى الجنة',
textAlign: TextAlign.center,
style: TextStyle(
  
fontSize: 18,

color: Colors.black,
height: 1.6,
),
),
const SizedBox(height: 20),
const Icon(Icons.refresh, color: Colors.deepPurple, size: 32),
],
),
),
Positioned(
top: 0,
left: (MediaQuery.of(context).size.width * 0.85 - 80) / 2,
child: Container(
width: 80,
height: 80,
decoration: BoxDecoration(
color: Colors.white,
shape: BoxShape.circle,
border: Border.all(color: Color(0xFFE6D89F)),
),
child: Center(
child: Icon(Icons.menu_book, color: Colors.deepPurple, size: 40),
),
),
),
Positioned(
top: 55,
left: 16,
child: Icon(Icons.share, color: Colors.deepPurple),
),
],
),
);
}}