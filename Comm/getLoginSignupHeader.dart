import 'package:dental_check/Widget/constant.dart';
import 'package:flutter/material.dart';

class getLoginSignupHeader extends StatelessWidget {
  String headerName;

  getLoginSignupHeader(this.headerName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 50.0),
          Text(
            headerName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: mPrimaryTextColor,
                fontSize: 40.0),
          ),
          SizedBox(height: 10.0),
          Image.asset(
            "assets/logo2.png",
            height: 150.0,
            width: 150.0,
          ),
          SizedBox(height: 10.0),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
