import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_app/pages/catalog.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String name = "utente";
    var titles = {
      "PANINI": "1",
      "PIADINE": "3",
      "BRIOCHES": "4",
      "SNACK": "5",
      "BIBITE": "2"
    };

    final List<Widget> images = [
      Container(
        decoration: BoxDecoration(
            //image: ,
            borderRadius: BorderRadius.circular(100),
            color: Color.fromARGB(255, 158, 11, 0)),
      ),
      Container(
        decoration: BoxDecoration(
            //image: ,
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromARGB(255, 255, 166, 0)),
      ),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color.fromARGB(255, 255, 17, 0)),
      ),
      InkWell(
          onTap: () {
            log('mzzz');
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Homepage(1)));
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color.fromARGB(255, 158, 11, 0)),
          )),
      Container(
        decoration: BoxDecoration(
            //image: ,
            borderRadius: BorderRadius.circular(100),
            color: Color.fromARGB(255, 255, 166, 0)),
      ),
    ];

    return Scaffold(
        body: SafeArea(
            top: false,
            left: true,
            child: Stack(
              children: <Widget>[
                Container(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                Positioned(
                    left: 5,
                    top: -31,
                    child: Container(
                      width: 23,
                      height: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xFFFF9B18)),
                    )),
                Positioned(
                    width: 23,
                    height: 56,
                    left: 35,
                    top: -13,
                    child: Container(
                      width: 23,
                      height: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xFFEE0F38)),
                    )),
                Positioned(
                    width: 400,
                    height: 270,
                    left: 24,
                    top: 60,
                    child: Container(
                        child: RichText(
                      text: TextSpan(
                        text: 'Ciao, ',
                        style: const TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            fontFamily: 'Inter'),
                        children: <TextSpan>[
                          TextSpan(
                              text: name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ))),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 100, 0, 10),
                  child: Expanded(
                    child: Container(
                      child: VerticalCardPager(
                          titles: titles.keys.toList(), // required
                          images: images, // required
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold), // optional
                          onPageChanged: (page) {
                            // optional
                          },
                          onSelectedItem: (index) {
                            if (!titles.values
                                .toList()
                                .contains((index + 1).toString())) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Errore")));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage(int.parse(
                                          titles.values.toList()[index]))));
                            }
                            // optional
                          },
                          initialPage: 0, // optional
                          align: ALIGN.CENTER // optional
                          ),
                    ),
                  ),
                )
              ],
            )),
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
                ]),
          ),
        ));
  }
}
