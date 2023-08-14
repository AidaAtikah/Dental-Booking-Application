import 'package:dental_check/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:dental_check/Widget/constant.dart';
import 'package:dental_check/Screen/service_form_page.dart';
import 'package:dental_check/Widget/header_logo.dart';
import 'package:dental_check/Widget/menu_card.dart';
import 'package:dental_check/Widget/my_header.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          MyHeader(
            height: 333,
            imageUrl: 'assets/welcome.png',
            child: Column(
              children: <Widget>[
                HeaderLogo(),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 28,
                    color: mTitleTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Choose your dental services',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 36,
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [mBackgroundColor, mSecondBackgroundColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Our Dental\nServices',
                          style: TextStyle(
                            color: mTitleTextColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.menu,
                          color: mSecondBackgroundColor,
                          size: 36,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MenuCard(
                        imageUrl: 'assets/scalling.png',
                        title: 'Scalling and Polishing',
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );
                        },
                      ),
                      MenuCard(
                        imageUrl: 'assets/crown.png',
                        title: 'Crown and Caps',
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MenuCard(
                        imageUrl: 'assets/filling.png',
                        title: 'Filling and Repair',
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );
                        },
                      ),
                      MenuCard(
                        imageUrl: 'assets/braces.png',
                        title: 'Braces',
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
