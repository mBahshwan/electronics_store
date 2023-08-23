import 'package:ecommerce_flutter/common/constant.dart';
import 'package:ecommerce_flutter/common/snakbar.dart';
import 'package:ecommerce_flutter/screens/user/homePage.dart';
import 'package:ecommerce_flutter/services/auth.dart';
import 'package:ecommerce_flutter/widgets/custom_logo.dart';
import 'package:ecommerce_flutter/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'SignupScreen';
  String? _email, _password;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            CustomLogo(),
            SizedBox(
              height: height * .1,
            ),
            CustomTextField(
              onClick: (value) {},
              icon: Icons.perm_identity,
              hint: 'Enter your name',
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              onClick: (value) {
                _email = value;
              },
              hint: 'Enter your email',
              icon: Icons.email,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              onClick: (value) {
                _password = value;
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
                  onPressed: () async {
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState!.save();
                      try {
                        await _auth.signUp(_email!.trim(), _password!.trim());

                        Navigator.pushNamed(context, HomePage.id);
                      } on PlatformException catch (e) {
                        showSnackBar(context: context, content: e.message!);
                      }
                    }
                  },
                  color: Colors.black,
                  child: Text(
                    'Sign up',
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
                  'Do have an account ? ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
