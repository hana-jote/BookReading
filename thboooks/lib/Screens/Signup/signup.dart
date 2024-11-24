import 'package:flutter/material.dart';
import 'package:thboooks/Screens/Signup/signupform.dart';
import 'package:thboooks/utils/ourtheme.dart';

class signup extends StatelessWidget {
  const signup({super.key});

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      BackButton(),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Register()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
