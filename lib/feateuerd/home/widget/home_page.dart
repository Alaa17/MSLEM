import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xff9ce3eb),
      body: SingleChildScrollView( // ✅ للسماح بالتمرير في حال تعدد المحتوى
        child: Column(
          children: [
            // صورة تأخذ 40% من الشاشة
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: Image.asset(
                'assets/images/ppp.png',
                fit: BoxFit.cover,
              ),
            ),
            Text('🌀أذكار المسلم🌀',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Amiri',
              fontWeight: FontWeight.bold,

            ),
            ),

Padding(
              padding: const EdgeInsets.all(25),
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  // ✅ الكروت القديمة
                  _buildCard(
                    context: context,
                    title: ' أذكار الصباح',
                    iconPath: 'assets/icon/sunrise.png',
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB7DCF7), Color(0xFFFFFFFF)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/quranPage');
                    },
                  ),
                  _buildCard(
                    context: context,
                    title: 'أذكار المساء',
                    iconPath: 'assets/icon/clear-sky.png',
                    gradient: const LinearGradient(
                      colors: [Color(0xFFACEEF7), Color(0xFFFFFFFF)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/azkarPage');
                    },
                  ),
                  _buildCard(
                    context: context,
                    title: 'أذكار النوم',
                    iconPath: 'assets/icon/sleep.png',
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEDB7F5), Color(0xFFFFFFFF)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/azkarsleep');
                    },
                  ),

                  // ✅ كروت جديدة
                  _buildCard(
                    context: context,
                    title: 'دعاء ألأنجاب',
                    iconPath: 'assets/icons/child.png',
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE2D6F5), Color(0xFFFFFFFF)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/prayerPage');
                    },
                  ),
                  _buildCard(
                    context: context,
                    title: 'أذكار الاستيقاظ',
                    iconPath: 'assets/icon/insomnia.png',
                    gradient: const LinearGradient(
                      colors: [Color(0xFFCCE5FF), Color(0xFFFFFFFF)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/morningAzkar');
                    },
                  ),
                  _buildCard(
                    context: context,
                    title: ' أدعية ألانبياء',
                    iconPath: 'assets/icon/dua.png',
                    gradient: const LinearGradient(
                      colors: [Color.fromARGB(255, 193, 252, 217), Color(0xFFFFFFFF)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/chaingpage');
                    },
                  ),
                  _buildCard(
                    context: context,
                    title: 'ألاستغفار',
                    iconPath: 'assets/icons/pray.png',
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFF3CF), Color(0xFFFFFFFF)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/fatwaPage');
                    },
                  ),
                  _buildCard(
                    context: context,
                    title: ' السبحة',                 
                    iconPath: 'assets/icons/beads.png',
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE2F5D6), Color(0xFFFFFFFF)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/ruqyahPage');
                    },
                  ),
                   _buildCard(
                    context: context,
                    title: 'أدعية السفر',
                    iconPath: 'assets/icon/travelling.png',
                    gradient: const LinearGradient(
                      colors: [Color.fromARGB(255, 245, 197, 201), Color(0xFFFFFFFF)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/travlpage');
                    }
                   )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ ويدجت بناء الكارت الموحد
  Widget _buildCard({
    required BuildContext context,
    required String title,
    required String iconPath,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              spreadRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Amiri',
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}