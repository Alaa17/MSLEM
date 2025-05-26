import 'package:flutter/material.dart';
import 'package:my_mslem/feateuerd/home/homeNavcaition/MorePage.dart';
import 'package:my_mslem/feateuerd/home/homeNavcaition/QuranPage.dart';
import 'package:my_mslem/feateuerd/home/homeNavcaition/AthkarPage.dart';
import 'package:my_mslem/feateuerd/home/homeNavcaition/KhatmahPage.dart';
import 'package:my_mslem/feateuerd/home/homeNavcaition/HomePage.dart';
import 'package:my_mslem/feateuerd/home/widget/home_page.dart';


class FlotingBottom extends StatefulWidget {
  const FlotingBottom({super.key});

  @override
  State<FlotingBottom> createState() => _FlotingBottomState();
}

class _FlotingBottomState extends State<FlotingBottom> {
  int selectedIndex = 2; // الصفحة الرئيسية مفعّلة بالبداية

  final List<String> navImages = [
    'assets/icons/more.png',
    'assets/icons/pray.png',
    'assets/icons/home.png',
    'assets/icons/salah.png',
    'assets/icons/quran.png',
  ];

  final List<String> navTitle = [
    'المزيد',
    'الأذكار',
    'الرئيسية',
    'الختمة',
    'المصحف',
  ];

  // الصفحات المرتبطة بالأزرار
  final List<Widget> pages = [
    const Morepage(),      // المزيد
      HomePage(),    // الأذكار
    const Moazenpage(),     // الرئيسية
    NewKhatmahPage(),       // الختمة
    const Quranpage(),      // المصحف
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9ce3eb),
      body: IndexedStack(
        index: selectedIndex,
        children: pages, // نعرض الصفحات كلها بالترتيب
      ),
      bottomNavigationBar: _navBar(),
    );
  }

  Widget _navBar() {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 3, 252, 11),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(navImages.length, (index) {
          bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  navImages[index],
                  width: 24,
                  height: 24,
                  color: isSelected
                      ? const Color.fromARGB(255, 3, 252, 11)
                      : Colors.white,
                ),
                const SizedBox(height: 4),
                Text(
                  navTitle[index],
                  style: TextStyle(
                    color: isSelected
                        ? const Color.fromARGB(255, 3, 252, 11)
                        : Colors.white,
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
