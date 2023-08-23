import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Container(
        height: MediaQuery.of(context).size.height * .2,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.network(
                "https://th.bing.com/th/id/OIP.3-DiKrqQ83F0HytDjM6qLwHaHa?w=219&h=219&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
          ],
        ),
      ),
    );
  }
}
