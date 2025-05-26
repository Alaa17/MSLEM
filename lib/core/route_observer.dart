import 'package:flutter/material.dart';
import 'package:my_mslem/feateuerd/Details_azkar/azkar_slawat_man.dart';
import 'package:my_mslem/feateuerd/Details_azkar/azkar_up_sleep.dart';
import 'package:my_mslem/feateuerd/Details_azkar/azkar_nithg.dart';
import 'package:my_mslem/feateuerd/Details_azkar/azkar_chaing_zker.dart';
import 'package:my_mslem/feateuerd/Details_azkar/azkar_sleep.dart';
import 'package:my_mslem/feateuerd/Details_azkar/azkar_uot_hmoe.dart';
import 'package:my_mslem/feateuerd/Details_azkar/azkar_inst_home.dart';
import 'package:my_mslem/feateuerd/Details_azkar/azkar_trivel.dart';
import 'package:my_mslem/feateuerd/Details_azkar/quranPage.dart';


// ✅ ملاحظة: لازم تكون مستورد الصفحات اللي هتتنقل ليها

/// مراقب التنقل بين الصفحات
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

/// تعريف الراوتات
class AppRoutes {
  static const String quran = '/quranPage';
  static const String azkar = '/azkarPage';
  static const String sleep = '/azkarsleep';
  static const String chaingpage = '/chaingpage';
  static const String morning = '/morningAzkar';
  static const String prayer = '/prayerPage';
  static const String travl = '/travlpage';
  static const String ruqy = '/ruqyahPage'; 
  static const String fatwa = '/fatwaPage';
 


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
    //  case home:
    //    return MaterialPageRoute(builder: (_) => const HomePage());
      case quran:
        return MaterialPageRoute(builder: (_) => const AKARMORNING());
      case azkar:
        return MaterialPageRoute(builder: (_) => const AzkarNithg());
      case sleep:
        return MaterialPageRoute(builder: (_) => const AzkarSleep());
      case prayer:
        return MaterialPageRoute(builder: (_) => const AzkarChang());
      case travl:
        return MaterialPageRoute(builder: (_) => const AzkarUp());
      case fatwa:
        return MaterialPageRoute(builder: (_) => const AzkarSlwat());
      case ruqy:
        return MaterialPageRoute(builder: (_) => const AzkarTrivel());
      case chaingpage:
        return MaterialPageRoute(builder: (_) => const AzkarOutHome());
      case morning:
        return MaterialPageRoute(builder: (_) => const AzkarInstHome());
      
      
     
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('الصفحة غير موجودة 🚫'),
            ),
          ),
        );
    }
  }
}
