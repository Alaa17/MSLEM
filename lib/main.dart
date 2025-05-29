import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_mslem/core/audioPlayer.dart';
import 'package:my_mslem/core/route_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('progressBox');
  await initializeDateFormatting('ar', null);
  runApp(MSLEM());
}

class MSLEM extends StatelessWidget {
  MSLEM({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo', // ✅ هنا حدد الخط
        textTheme: GoogleFonts.notoNaskhArabicTextTheme(),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const SplashScreen(),
     // initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
      navigatorObservers: [routeObserver],
    );
  }
}
