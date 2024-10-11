// ignore_for_file: prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:io';
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travelverse_mobile_app/src/login/login_form.dart';

class VouchersView extends StatelessWidget {
  VouchersView({super.key});

  @override
  Widget build(BuildContext context) {
    final currHeight = MediaQuery.of(context).size.height;
    final currWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              height: currHeight * 0.11,
              padding: EdgeInsets.symmetric(horizontal: 38),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(
                            context); // Go back to the previous screen
                      },
                      child: Image.asset('assets/images/BackIconVisa.png'))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: currHeight * 0.4,
              width: currWidth,
              child: Image.asset(
                'assets/images/BlueWave.png',
                fit: BoxFit.fill,
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 35),
                  padding: EdgeInsets.symmetric(horizontal: 44),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Center(
                    child: MainContent(),
                  ),
                ),
                Positioned(
                  top: -245,
                  left: 113,
                  child: Image.asset('assets/images/Gift.png'),
                )
              ],
            ),
            SizedBox(
              height: 18,
            )
          ],
        ),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Gift',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'Complimentary Sightseeing in Italy for 2 people.',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300),
              ),
            ),
            Flexible(
              flex: 2,
              child: Image.asset(
                'assets/images/Sparkle.png',
                width: 52,
              ),
            )
          ],
        ),
        SizedBox(
          height: 80,
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            'Need Help?',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF989898),
              padding: EdgeInsets.symmetric(vertical: 9, horizontal: 20),
              fixedSize: Size(98, 33),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
        )
      ],
    );
  }
}
