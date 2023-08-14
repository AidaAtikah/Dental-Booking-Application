import 'package:dental_check/screen/LoginForm.dart';
import 'package:flutter/material.dart';
import 'package:dental_check/Widget/constant.dart';
import 'package:dental_check/Widget/header_logo.dart';
import 'package:dental_check/screen/LoginForm.dart';
import 'package:dental_check/widget/my_header.dart';

class StartupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          MyHeader(
            height: 535,
            imageUrl: 'assets/doctor.png',
            child: HeaderLogo(),
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
                  Text(
                    'Dental Booking App',
                    style: TextStyle(
                        fontSize: 32,
                        color: mTitleTextColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Hello, Welcome to our Dental Clinic A&A App',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: mTitleTextColor),
                  ),
                  Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: FlatButton(
                      color: mButtonColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginForm();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Book Now',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
