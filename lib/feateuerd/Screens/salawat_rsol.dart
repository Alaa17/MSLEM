import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SalawatCard extends StatefulWidget {
  @override
  _SalawatCardState createState() => _SalawatCardState();
}

class _SalawatCardState extends State<SalawatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentIndex = 0;

  final List<String> salawatList = [
    'اللهم صلِّ على سيدنا محمد وعلى آله وصحبه وسلم',
    'اللهم صلِّ على سيدنا محمد عدد ما ذكره الذاكرون وغفل عن ذكره الغافلون',
    'اللهم صلِّ على سيدنا محمد في الأولين والآخرين وفي الملأ الأعلى إلى يوم الدين',
    'اللهم صلِّ وسلم وبارك على سيدنا محمد وعلى آله عدد خلقك ورضا نفسك وزنة عرشك ومداد كلماتك',
    'اللهم صلِّ على سيدنا محمد صلاة تشرح بها صدورنا وتغفر بها ذنوبنا وترزقنا بها شفاعته يوم القيامة',
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
  }

  void _changeSalawat() {
    _controller.forward(from: 0);
    setState(() {
      _currentIndex = (_currentIndex + 1) % salawatList.length;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // الكارت
          Container(
            width: 360,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
             vertical: 20),
            margin: const EdgeInsets.only(top: 40), // عشان الريشة تبان طالعة
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.deepPurple.shade900,
              
              
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30), // مسافة تحت الريشة
                Text(
                  'صلوات',
                  style: GoogleFonts.cairo(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Text(
                    salawatList[_currentIndex],
                    key: ValueKey(_currentIndex),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _changeSalawat,
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeInOut,
                      ),
                      
                    ),
                    
                    child: CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.refresh, color: Colors.deepPurple),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // أيقونة الريشة في الأعلى ومنحوتة بالكارت
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            
            child: Center(
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.amber.shade200, 
                    ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/images/frame.png',
                   // color: Colors.deepPurple,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
