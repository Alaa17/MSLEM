import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_mslem/feateuerd/home/Khatmah/bottom_Navigation_Bar.dart';
import 'package:my_mslem/feateuerd/home/widget/home_page.dart';

class TowKhatmahPage extends StatelessWidget {
   TowKhatmahPage({super.key});
int totalParts = 30; // عدد الأجزاء الكاملة (مثلاً ختمة كاملة)
int currentPart = 5; // الجزء اللي وصل له المستخدم حالياً (تقدر تحدثه)




// حفظ
void saveProgress(int part) {
  final box = Hive.box('progressBox');
  box.put('currentPart', part);
}

// استرجاع
int loadProgress() {
  final box = Hive.box('progressBox');
  return box.get('currentPart', defaultValue: 0);
}





  @override
  Widget build(BuildContext context) {
    return Container(
      // ✅ خلفية التطبيق كلها بلون متدرج
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
           
            Color.fromARGB(255, 34, 10, 243),
             Color(0xffFFFFFF),
             Color.fromARGB(255, 102, 78, 209),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // ✅ خلي الخلفية شفافة علشان يبان التدرج
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.share, color: Colors.white),
                Icon(Icons.bookmark_added_outlined, color: Colors.white),
                SizedBox(width: 160),
                Text(
                  'الورد الحالي',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 🔽 هنا يبدأ الكارت بتاعك
              Container(
                height: 320,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Color(0xfff0fff0)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الجزء الثاني',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            'من قوله تعالي',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Center(
                      child: Text(
                        'كل الطعام كان حلا لبني أسرأئيل',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          'صفحة 72',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.green.shade600,
                          ),
                        ),
                        Spacer(flex: 1),
                        Text(
                          'سورةأل عمران-أية171 ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.green.shade600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 1.5,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Row(
                      children: [
                        Text(
                          'صفحة106',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.green.shade600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'ألي سورةالنساء-أية23',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.green.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
SizedBox(height: 20,),
              Row(
                children: [
                  FilledButton(
                   onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green), // لون الخلفية
                      minimumSize: MaterialStateProperty.all(Size(170, 60)), // العرض والطول
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // نصف قطر الزوايا
                           // لون وسمك البوردر
                        ),
                      ),
                    ),
                  child: Text('أقرء الورد',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                  )),
                  SizedBox(width: 30,),
                  FilledButton(
                   onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xffefd621)), // لون الخلفية
                      minimumSize: MaterialStateProperty.all(Size(170, 60)), // العرض والطول
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // نصف قطر الزوايا
                           // لون وسمك البوردر
                        ),
                      ),
                    ),
                  child: Text('أتتمت القراءة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                  )),
                ],
              ),
              SizedBox(height: 50),
               Container(
                      width: double.infinity,
                      height: 0.8,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('❤️انت سابق ختمتك ب3أيام',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,

                        ),
                        ),
                        Text('الختمه الحالية ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          
                        ),
                        ),
                       

                      ],
                      
                    ),
                    SizedBox(height: 20,),
                       LinearProgressIndicator(
  value: 0.4, // يعني 40% تقدم
  minHeight: 8,
  backgroundColor: Colors.grey[300],
  color: Colors.green,
),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('الأوراد القادمة:25',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          
                        ),),
    Text('الأوراد السابقة:4',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          
                        ),)
  ],
),


              // 🔽 هنا ممكن تضيف الأزرار بعد الكارت
  // تحت الـ Container الموجود

              // مثال:
              // SizedBox(height: 20),
              // ElevatedButton(onPressed: () {}, child: Text("التالي")),
            ],
          ),
        ),
      ),
    );
  }
}
