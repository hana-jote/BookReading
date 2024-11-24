import 'package:flutter/material.dart';
import 'package:thboooks/Screens/Login/loginform.dart';
import 'package:thboooks/utils/ourtheme.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: OurTheme.theme,
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.all(60.0),
                    //child: Image.asset("assets/logo.png"),
                  ),
                  Login()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
