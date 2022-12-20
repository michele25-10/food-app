import 'package:flutter/material.dart';
import 'package:sandwech/utils/circle_button.dart';
import 'package:sandwech/utils/size.dart';
import 'package:sandwech/utils/GNav.dart';

class ProfilePage extends StatefulWidget {
  // final int userID;
  // const CartPage(this.userID, {super.key});
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 75)),
              Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'lib/assets/images/profile.png',
                      width: 200,
                      height: 200,
                    ),
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: const GNavi(1),
    );
  }
}
