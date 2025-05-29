import 'package:flutter/material.dart';
import 'package:my_mslem/constint.dart';
import 'package:my_mslem/feateuerd/home/Khatmah/next_tow_Page.dart';


class NextKhatma extends StatefulWidget {
  @override
  _NextKhatmaState createState() => _NextKhatmaState();
}

class _NextKhatmaState extends State<NextKhatma> {
  int days = 4;
  int parts = 7;
  int quarters = 7;

  List<int> partsList = List.generate(30, (i) => i + 1);
  List<int> quartersList = List.generate(8, (i) => i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebebdc),
      appBar: AppBar(
  title: const Text('أذكار الصباح',style: TextStyle(color: Colors.white),),
  centerTitle: true,
  backgroundColor: AppColors.primaryColor,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back,color: Colors.white,),
    onPressed: () {
      Navigator.pop(context); // يرجع للخلف
    },
  ),
),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 95),
            Text(
              'الرجاء تحديد المدة التي تريد أن تختم فيها أو كمية الورد اليومي الذي تود قراءته',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 40),

            // ✅ مدة الختمة: زر زائد وناقص داخل كونتينر
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (days > 1) days--;
                              });
                            },
                            icon: Icon(Icons.remove),
                            color: AppColors.primaryColor,
                          ),
                          Container(
      width: 1, // 👈 عرض الخط
      height: 26, // 👈 طول الخط
      color:AppColors.primaryColor, // 👈 لون الخط
      margin: EdgeInsets.symmetric(horizontal: 8),
    ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                days++;
                              });
                            },
                            icon: Icon(Icons.add),
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        '$days أيام',
                        style:
                            TextStyle(fontSize: 19, 
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
                Text("مدة الختمة" , style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,)),
              ],
            ),

            SizedBox(height: 30),

            // ✅ كمية الورد مع خلفية بيضاء لكل عنصر
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
              //  color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // أرباع في كونتينر
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: quarters,
                            items: quartersList.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text('$e أرباع',
                                style: TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18
),),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                quarters = val!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
Text('و',
style: TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.bold,
  fontSize: 22
),),
                      // أجزاء في كونتينر
                      SizedBox(width: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: parts,
                            items: partsList.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text('$e أجزاء',
                                style: TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18
), ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                parts = val!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text("كمية الورد", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
                ],
              ),
            ),

         //   Spacer(),
SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TowKhatmahPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:AppColors.primaryColor,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'الاستمرار',
                style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                 color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
