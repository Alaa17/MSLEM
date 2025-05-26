import 'package:flutter/material.dart';
import 'package:my_mslem/core/route_observer.dart';
import 'package:my_mslem/feateuerd/home/widget/card_view.dart';

class Morepage extends StatefulWidget {
  const Morepage({super.key});

  @override
  State<Morepage> createState() => _MorepageState();
}

class _MorepageState extends State<Morepage>
    with TickerProviderStateMixin, RouteAware {
  final List<Map<String, dynamic>> cardsData = [
    {'title': 'الأذكار', 'image': 'assets/icons/man.png'},
    {'title': 'سنن الجمعة', 'image': 'assets/icons/prayv.png'},
    {'title': 'أدعية للميت', 'image': 'assets/icons/islam.png'},
    {'title': 'الأحاديث', 'image': 'assets/icons/man.png'},
    {'title': 'الأدعية', 'image': 'assets/icons/prayj.png'},
    {'title': 'أذكار السفر', 'image': 'assets/icons/dual.png'},
    {'title': 'الأذان', 'image': 'assets/icons/adzan.png'},
    {'title': 'ادعية للمتزوج', 'image': 'assets/icons/gjgj.png'},
    {'title': 'الصلوات', 'image': 'assets/icons/salat.png'},
    {'title': 'الزكاة', 'image': 'assets/icons/zakat.png'},
    
    
   
    {'title': 'تسبيح', 'image': 'assets/icons/tasbihhh.png'},
    {'title': 'الرقية الشرعية', 'image': 'assets/icons/worship.png'},
    {'title': 'الاستغفار', 'image': 'assets/icons/sujud.png'},
    {'title': 'غرس الجنة', 'image': 'assets/icons/salat.png'},
    {'title': 'ادعية للمريض', 'image': 'assets/icons/prayv.png'},
  ];

  final int cardsCount = 15;
  final List<AnimationController> _controllers = [];
  final List<Animation<Offset>> _slideAnimations = [];
  final List<Animation<double>> _fadeAnimations = [];
  final List<Animation<double>> _scaleAnimations = [];
  bool _animationPlaying = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    for (int i = 0; i < cardsCount; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      );
      final slideAnimation = Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
      final fadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
      final scaleAnimation = Tween<double>(
        begin: 0.8,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
      _controllers.add(controller);
      _slideAnimations.add(slideAnimation);
      _fadeAnimations.add(fadeAnimation);
      _scaleAnimations.add(scaleAnimation);
    }
  }

  Future<void> _playAnimations() async {
    if (_animationPlaying) return;
    _animationPlaying = true;
    for (var controller in _controllers) {
      controller.reset();
    }
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 90));
      if (!mounted) return;
      _controllers[i].forward();
    }
    _animationPlaying = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    _playAnimations();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  void didPush() {
    _playAnimations();
  }

  @override
  void didPopNext() {
    _playAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9ce3eb),
      appBar: AppBar(
        title: const Text(
          '🌀زاد المسلم🌀',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff9ce3eb),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: List.generate(cardsCount, (index) {
            return AnimatedBuilder(
              animation: _controllers[index],
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimations[index].value,
                  child: Transform.translate(
                    offset: _slideAnimations[index].value,
                    child: Transform.scale(
                      scale: _scaleAnimations[index].value,
                      child: child,
                    ),
                  ),
                );
              },
              child: MyAnimatedCard(
                title: cardsData[index]['title'],
                imagePath: cardsData[index]['image'],
                defaultGradient: const LinearGradient(
                  colors: [
                    
                  Color(0xFFACEEF7), Color(0xFFFFFFFF)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,

                ),
                pressedGradient: const LinearGradient(
                  colors: [Color(0xfff7971e), Color(0xffffd200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onTap: () {
                  switch (index) {
                    case 0:
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const FirstCardPage()));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SecondCardPage()));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ThirdCardPage()));
                      break;
                    case 3:
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const FourthCardPage()));
                      break;
                    default:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DefaultDetailPage(cardNumber: index + 1)),
                      );
                  }
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}

class FirstCardPage extends StatelessWidget {
  const FirstCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('صفحة الأذكار')),
      body: const Center(
        child: Text('محتوى صفحة الأذكار', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class SecondCardPage extends StatelessWidget {
  const SecondCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('صفحة القبلة')),
      body: const Center(
        child: Text('محتوى صفحة القبلة', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class ThirdCardPage extends StatelessWidget {
  const ThirdCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('صفحة القرآن')),
      body: const Center(
        child: Text('محتوى صفحة القرآن', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class FourthCardPage extends StatelessWidget {
  const FourthCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('صفحة الأحاديث')),
      body: const Center(
        child: Text('محتوى صفحة الأحاديث', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class DefaultDetailPage extends StatelessWidget {
  final int cardNumber;
  const DefaultDetailPage({super.key, required this.cardNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('صفحة الكارت رقم $cardNumber')),
      body: Center(
        child: Text(
          'هذه صفحة افتراضية للكارت رقم $cardNumber',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
