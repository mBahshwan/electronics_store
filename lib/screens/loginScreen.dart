import 'package:ecommerce_flutter/common/constant.dart';
import 'package:ecommerce_flutter/common/snakbar.dart';
import 'package:ecommerce_flutter/provider/adminMode.dart';
import 'package:ecommerce_flutter/screens/admin/adminHome.dart';
import 'package:ecommerce_flutter/screens/signupScreen.dart';
import 'package:ecommerce_flutter/screens/user/homePage.dart';
import 'package:ecommerce_flutter/services/auth.dart';
import 'package:ecommerce_flutter/widgets/custom_logo.dart';
import 'package:ecommerce_flutter/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email, password;

  final _auth = Auth();

  final adminPassword = 'Admin1234';

  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: widget.globalKey,
        child: ListView(
          children: <Widget>[
            CustomLogo(),
            SizedBox(
              height: height * .1,
            ),
            CustomTextField(
              onClick: (value) {
                _email = value;
              },
              hint: 'Enter your email',
              icon: Icons.email,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: <Widget>[
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.white),
                    child: Checkbox(
                      checkColor: kSecondaryColor,
                      activeColor: kMainColor,
                      value: keepMeLoggedIn,
                      onChanged: (value) {
                        setState(() {
                          keepMeLoggedIn = value!;
                        });
                      },
                    ),
                  ),
                  Text(
                    'Remmeber Me ',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            CustomTextField(
              onClick: (value) {
                password = value;
              },
              hint: 'Enter your password',
              icon: Icons.lock,
            ),
            SizedBox(
              height: height * .05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: Builder(
                builder: (context) => MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    if (keepMeLoggedIn == true) {
                      keepUserLoggedIn();
                    }
                    _validate(context);
                  },
                  color: Colors.black,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * .05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Don\'t have an account ? ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignupScreen.id);
                  },
                  child: Text(
                    'Signup',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeIsAdmin(true);
                      },
                      child: Text(
                        'i\'m an admin',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin
                                ? kMainColor
                                : Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeIsAdmin(false);
                      },
                      child: Text(
                        'i\'m a user',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Provider.of<AdminMode>(context, listen: true)
                                    .isAdmin
                                ? Colors.white
                                : kMainColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    if (widget.globalKey.currentState!.validate()) {
      widget.globalKey.currentState!.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (password == adminPassword) {
          try {
            await _auth.signIn(_email!.trim(), password!.trim());
            Navigator.pushNamed(context, AdminHome.id);
          } on PlatformException catch (e) {
            showSnackBar(context: context, content: e.message!);
          }
        } else {
          showSnackBar(context: context, content: "Something went wrong !");
        }
      } else {
        try {
          await _auth.signIn(_email!.trim(), password!.trim());
          Navigator.pushNamed(context, HomePage.id);
        } on PlatformException catch (e) {
          showSnackBar(context: context, content: e.message!);
        }
      }
    }
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}
