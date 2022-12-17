import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:sandwech/pages/catalog.dart';
import 'package:sandwech/utils/navbar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: const Color.fromRGBO(166, 4, 0, 1),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(
                        CupertinoIcons.person_fill,
                        color: Colors.white,
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.home,
                      color: Colors.white,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        CupertinoIcons.shopping_cart,
                        color: Colors.white,
                      ),
                      label: '')
                ],
              ),
            )));
  }
}
