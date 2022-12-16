import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sandwech/types/product.dart';
import 'package:sandwech/utils/utils.dart';
import 'package:sandwech/utils/calculation.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Pagina del singolo prodotto
///
/// Bisogna passare al costruttore l'id del prodotto in formato [int]
class ProductPage extends StatefulWidget {
  final int idProduct; // attributo

  const ProductPage(this.idProduct, {super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String paninoPath = "lib/assets/panino.png";
  // ignore: prefer_const_constructors
  Product prodotto = Product(id: '0', name: '', price: '');

  @override
  void initState() {
    super.initState();
    getSingleProduct(widget.idProduct.toString()).then(
        (value) => setState(() {
              prodotto = value as Product;
              checkDescription(prodotto.description as String);
            }), onError: (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Sending Message"),
      ));
    });
  }

  /// Controlla se la descrizione contiene qualcosa, sennò ritorna una stringa preimpostata
  String checkDescription(String str) {
    if (str.isNotEmpty) {
      return str;
    } else {
      return "Descrizione non disponibile";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Image.asset(paninoPath),
        Positioned(
          top: 40,
          left: 10,
          child: ButtonCircle(30, () {
            Navigator.pop(context);
          }, Icons.arrow_back_ios),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
              color: Colors.white,
            ),
            height: calcPercentage(MediaQuery.of(context).size.height, 57),
            width: MediaQuery.of(context).size.width,
            child: Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 27, left: 27, right: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: calcPercentage(
                          MediaQuery.of(context).size.height, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // nome prodotto
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              prodotto.name,
                              textAlign: TextAlign.left,
                              textScaleFactor: 1.9,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          //icona a destra del nome del prodotto
                          Align(
                            alignment: Alignment.topRight,
                            child: SvgPicture.asset(
                              "lib/assets/left_side_pills.svg",
                              semanticsLabel: 'Pills',
                              width: 55,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //informazioni relative al prodotto, con tanto di pulsanti
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          const Divider(
                            color: Colors.grey,
                            height: 20,
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Descrizione",
                              textAlign: TextAlign.left,
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              prodotto.description as String,
                              textScaleFactor: 1,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Ingredienti",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.5,
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
        )
      ]),
    );
  }
}

/// Widget per crare un pulsante rotondo, bianco
class ButtonCircle extends StatelessWidget {
  final double size;
  final GestureTapCallback onTap;
  final IconData iconData;

  /// [double] size: rappresenta la grandezza del cerchio
  ///
  /// [GestureTapCallback] onTap: è la funzione che viene eseguita quando si clicca il pulsante
  ///
  /// [IconData] iconData: è l'icona che sta al centro del cerchio
  const ButtonCircle(this.size, this.onTap, this.iconData, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            iconData,
            color: Colors.black,
            size: 22,
          ),
        ),
      ),
    );
  }
}
