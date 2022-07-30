import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'compose_mail.dart';
import 'mail_screen.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  GlobalKey<CurvedNavigationBarState> _NavKey=GlobalKey();

  var PagesAll=[mailScreen(),SpeechSampleApp()];
  var myindex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: [Icon(Icons.inbox),Icon(Icons.message)],
        buttonBackgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            myindex = index;
          });
        },
        animationCurve: Curves.fastLinearToSlowEaseIn,color: Colors.pinkAccent,
      ),
      body: PagesAll[myindex],
    );
  }
}
