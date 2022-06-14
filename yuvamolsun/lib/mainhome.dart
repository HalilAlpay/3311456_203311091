import 'package:flutter/material.dart';
import 'package:yuvamolsun/anasayfa.dart';


class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int currentIndex = 0;

  List pages = [
    PageCategories(),

  ];

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFFFF6969),
          unselectedItemColor: Color(0xFF727C8E),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: currentIndex,
          onTap: (e) {
            setState(() {
              currentIndex = e;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label:("Ana Sayfa")),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: ("Ara")),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: ("Bilgiler")),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: ("Mesajlar")),

          ]),
    );
  }
}
