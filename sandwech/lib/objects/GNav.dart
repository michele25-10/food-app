/* import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GNav extends StatefulWidget {
  const GNav({Key? key}) : super(key: key);

  @override
  State<GNav> createState() => _GNavState();
}

class _GNavState extends State<GNav> {
  int _currentIndex = 0;
  List<Widget> body = const [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: body[_currentIndex]),
        bottomNavigationBar: Container(
          color: Colors.white,
          // ignore: prefer_const_constructors
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: const GNav(
              color: Color.fromARGB(255, 255, 166, 0),
              activeColor: Colors.red,
              //tabBackgroundColor: Colors.grey,
              gap: 8,

              tabs: [
                GButton(
                  icon: Icons.person,
                  text: 'Profilo',
                ),
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(icon: Icons.shopping_cart, text: 'Carrello'),
              ],
            ),
          ),
        ));
  }
}
*/