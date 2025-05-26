class ModelAthzar {
  final String title;
  final String iconPath;
  final String route;

  ModelAthzar({required this.title, required this.iconPath, required this.route});

  
}

final List<ModelAthzar> azkarCards = [
 ModelAthzar(title: 'أدعية النبي', iconPath: 'assets/icons/prophet.png', route: '/prophet'),
  ModelAthzar(title: 'أدعية الأنبياء من القرآن', iconPath: 'assets/icons/quran.png', route: '/quran'), 
  ModelAthzar(title: 'أدعية أخرى', iconPath: 'assets/icons/other.png', route: '/other'), 
  ModelAthzar(title: 'أدعية للميت', iconPath: 'assets/icons/dead.png', route: '/dead'), 
  ModelAthzar(title: 'أدعية للمريض', iconPath: 'assets/icons/sick.png', route: '/sick'), 
  ModelAthzar(title: 'أدعية للمتزوج', iconPath: 'assets/icons/married.png', route: '/married'),
  ModelAthzar(title: 'أذكار الثوب', iconPath: 'assets/icons/clothes.png', route: '/clothes'),
  ModelAthzar(title: 'أذكار الاستيقاظ من النوم', iconPath: 'assets/icons/wakeup.png', route: '/wakeup'),
  ModelAthzar(title: 'أذكار الأذان', iconPath: 'assets/icons/azan.png', route: '/azan'),
  ModelAthzar(title: 'أذكار الصباح', iconPath: 'assets/icons/morning.png', route: '/morning'), 
  ModelAthzar(title: 'أذكار السفر', iconPath: 'assets/icons/travel.png', route: '/travel'),
  ModelAthzar(title: 'أذكار الحج والعمرة', iconPath: 'assets/icons/hajj.png', route: '/hajj'), ];