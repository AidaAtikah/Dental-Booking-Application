import 'package:dental_check/Screen/welcome_screen.dart';
import 'package:dental_check/Widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:dental_check/Comm/getLoginSignupHeader.dart';
import 'package:dental_check/Comm/getTextFormField.dart';
import 'package:dental_check/Databases/database_user.dart';
import 'package:dental_check/Model/user.dart';
import 'package:dental_check/Screen/SignupForm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dental_check/Screen/home_page.dart';
import 'package:dental_check/Screen/welcome_screen.dart';
import 'package:toast/toast.dart';


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseUser();
  }

  login() async {
    String uid = _conUserId.text;
    String passwd = _conPassword.text;

    if (uid.isEmpty) {
      alertDialog(context, "Please Enter User ID");
    } else if (passwd.isEmpty) {
      alertDialog(context, "Please Enter Password");
    } else {
      await dbHelper.getLoginUser(uid, passwd).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Error: Not Found User ID");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error: Login Fail");
      });
    }
  }

  Future setSP(User user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id);
    sp.setString("user_name", user.user_name);
    sp.setString("email", user.email);
    sp.setString("password", user.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dental Clinic A&A'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getLoginSignupHeader('Login'),
                getTextFormField(
                    controller: _conUserId,
                    icon: Icons.person,
                    hintName: 'User ID'),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                ),
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: login,
                  ),
                  decoration: BoxDecoration(
                    color: mButtonColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Does not have account? '),
                      FlatButton(
                        textColor: mPrimaryTextColor,
                        child: Text('Signup'),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignupForm()));
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

alertDialog(BuildContext context, String msg) {
  Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
}

