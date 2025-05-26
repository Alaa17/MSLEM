import 'package:flutter/material.dart';
import 'package:my_mslem/feateuerd/models/model_athzar.dart';

class AzkarHomePage extends StatelessWidget { 
    const AzkarHomePage({super.key});

@override Widget build(BuildContext context)
 { 
    return Scaffold( 
        appBar: AppBar( 
            backgroundColor: Colors.green[900], 
            title: const Text('أذكار', 
            style: TextStyle(color: Colors.white)), 
            centerTitle: true, 
            iconTheme: const IconThemeData(color: Colors.white), ), 
            body: GridView.builder( padding: const EdgeInsets.all(12), 
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( 
                crossAxisCount: 3, crossAxisSpacing: 12, 
                mainAxisSpacing: 12, childAspectRatio: 0.85, ), 
                itemCount: azkarCards.length, 
                itemBuilder: (context, index) { final card = azkarCards[index]; 
                return GestureDetector( onTap: () { Navigator.pushNamed(context,
                 card.route); }, 
                 child: Container( 
                    decoration: BoxDecoration( 
                        color: Colors.green[700], 
                        borderRadius: BorderRadius.circular(12), 
                        border: Border.all(color: Colors.black, width: 2), ), 
                        child: Column( mainAxisAlignment: MainAxisAlignment.center, 
                        children: [ Image.asset( card.iconPath, width: 40, height: 40, 
                        color: Colors.white, ), 
                        const SizedBox(height: 10), 
                        Text( card.title, textAlign: TextAlign.center, 
                        style: const TextStyle( color: Colors.white, 
                        fontSize: 14, fontWeight: FontWeight.bold,
                         ),
                          ),
                           ],
                            ),
                             ),
                              );
                               },
                                ),
                                 );
                                  }
                                   }

// 4. صفحة أذكار الصباح 
class MorningAzkarPage extends StatelessWidget { const MorningAzkarPage({super.key});

@override 
Widget build(BuildContext context) { 
    return Scaffold( 
        appBar: AppBar( 
            backgroundColor: Colors.green[900], 
            title: const Text('أذكار الصباح', 
            style: TextStyle(color: Colors.white)), 
            centerTitle: true, 
            iconTheme: const IconThemeData(color: Colors.white), ), 
            body: ListView( 
                padding: const EdgeInsets.all(16), 
                children: const [ 
                    Text( 'اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ، خَلَقْتَني ...', 
                    style: TextStyle(fontSize: 18), ), 
                    SizedBox(height: 12), 
                    Text( 'رَضيـتُ بِاللهِ رَبّـاً، وبِالإسْلامِ ديـناً، وبِمُحَـمّدٍ ...', 
                    style: TextStyle(fontSize: 18), ),
                ]
                )
                );
                }
                     // أضف باقي الأذكار هنا 
                    } 