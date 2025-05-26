import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  final List<String> navImages = const [
    'assets/icons/more.png',
    'assets/icons/pray.png',
    'assets/icons/home.png',
    'assets/icons/salah.png',
    'assets/icons/quran.png',
  ];

  final List<String> navTitle = const [
    'المزيد',
    'الأذكار',
    'الرئيسية',
    'الختمة',
    'المصحف',
  ];

  @override
  Widget build(BuildContext context) {
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
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onTap(index),
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
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
