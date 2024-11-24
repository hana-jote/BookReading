import 'package:flutter/material.dart';

class thcontainer extends StatelessWidget {
  final Widget child;

  const thcontainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          // ignore: prefer_const_constructors
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: const Offset(4.0, 4.0),
          )
        ],
      ),
      child: child,
    );
  }
}
