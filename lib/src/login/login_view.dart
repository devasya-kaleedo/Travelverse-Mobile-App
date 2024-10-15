// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travelverse_mobile_app/src/login/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final currHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.cyan,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        child: Column(children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Color(0xFF03C3DF),
            ),
          ),
          Expanded(
            flex: 5,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  padding: EdgeInsets.only(left: 64, top: 32, right: 64),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: LoginForm(),
                  ),
                ),
                Positioned(
                  top: -115,
                  left: 66,
                  child: Image.asset(
                    'assets/images/ManWithLuggage.png',
                    width: 53,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: -180,
                  right: -20,
                  child: Image.asset(
                    'assets/images/FlightAeroplane.png',
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
