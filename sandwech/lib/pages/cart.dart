import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sandwech/utils/calculation.dart';
import 'package:sandwech/utils/size.dart';
import 'package:sandwech/utils/GNav.dart';
import 'package:sandwech/utils/utils.dart';
import 'package:sandwech/utils/cart_card.dart';
import 'package:sandwech/types/product.dart';
import 'package:sandwech/types/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:sandwech/pages/confirmOrder.dart';

class CartPage extends StatefulWidget {
  final User userData;

  const CartPage(this.userData, {super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String productName = "";
  //String nomeUtente = "";
  List<Product> productList = List.empty(growable: true);
  String capitalize(String str) {
    return str[0].toUpperCase() + str.substring(1);
  }

  void deleteitem(int pos) {
    setState(() {
      Product removed = productList[pos];
      productList.removeAt(pos);
      print("Deleted item at position $pos, name: ${removed.name}");
    });
  }

  @override
  void initState() {
    super.initState();
    getCart(widget.userData.id.toString()).then(
        (value) => setState(() {
              productList = value;
            }), onError: (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Sending Message"),
      ));
    });
  }

  EdgeInsets getMarginDevice(double android, double ios) {
    if (Platform.isAndroid) {
      return EdgeInsets.only(bottom: android);
    } else if (Platform.isIOS) {
      return EdgeInsets.only(bottom: ios);
    }
    return const EdgeInsets.only(top: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFFFFFFF),
          ),
          Positioned(
            width: 23,
            height: 56,
            left: 4,
            top: -28,
            child: Container(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color(0xFFFF9B18),
            )),
          ),
          Positioned(
              width: 23,
              height: 56,
              left: 32,
              top: -15,
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
              left: 20,
              top: 68,
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
                        text: widget.userData.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              )),
          Positioned(
              left: (MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.width - 30)) /
                  2,
              width: (MediaQuery.of(context).size.width) - 30,
              top: 110,
              child: Material(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: CupertinoSearchTextField(
                        borderRadius: BorderRadius.circular(20),
                        placeholder: 'Cerca qualcosa...',
                        prefixInsets: const EdgeInsets.only(left: 10),
                        suffixIcon:
                            const Icon(CupertinoIcons.slider_horizontal_3),
                        suffixMode: OverlayVisibilityMode.always,
                        suffixInsets: const EdgeInsets.only(right: 10),
                        onSuffixTap: () {},
                      ),
                    ),
                  ],
                ),
              )),
          Container(
            margin: const EdgeInsets.only(top: 160),
            height: calcPercentage(MediaQuery.of(context).size.height, 55),
            child: (() {
              if (productList.isEmpty) {
                return Center(
                    child: RichText(
                  text: const TextSpan(
                    text: ("Nessun prodotto"),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CartCard(
                      int.parse(productList[index].tagID as String),
                      productList[index].name,
                      productList[index].price,
                      productList[index].quantity,
                      productList[index].id,
                      widget.userData,
                      uniqueID: index,
                      removeItem: deleteitem,
                    );
                  },
                );
              }
            }()),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConfirmOrderWidget(
                              widget.userData,
                            )));
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: getMarginDevice(25, 50),
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromARGB(255, 158, 11, 0),
                    ),
                    child: Text(
                      'Ordina',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: getFontSize(24)),
                      textAlign: TextAlign.center,
                    )),
              )),
        ],
      ),
      bottomNavigationBar: GNavi(2, widget.userData),
    );
  }
}
