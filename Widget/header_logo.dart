import 'package:flutter/material.dart';
import 'package:dental_check/widget/constant.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/logo1.png',
            width: 70,
            height: 70,
          ),
          SizedBox(width: 12,),
          Text(
            'Dental Clinic A&A',
            style: TextStyle(
              fontSize: 26,
              color:mTitleTextColor,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}