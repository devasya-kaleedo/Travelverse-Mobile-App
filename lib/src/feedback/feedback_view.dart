// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FeedbackView extends StatelessWidget {
  FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    final currHeight = MediaQuery.of(context).size.height;
    final currWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 360,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  MapContainer(),
                  Positioned(
                    left: 38,
                    bottom: 27,
                    child: HeadingCard(),
                  ),
                  Positioned(
                      bottom: -4,
                      left: 53,
                      child: Image.asset('assets/images/DownArrowBlue.png'))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 44),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    SentimentIndicator(),
                    SizedBox(
                      height: 27,
                    ),
                    TextArea(),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF03C3DF),
                            padding: EdgeInsets.symmetric(
                                horizontal: 31, vertical: 9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        )),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SentimentIndicator extends StatelessWidget {
  const SentimentIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 4,
      children: [
        Image.asset(
          'assets/images/Happy.png',
          width: 43,
        ),
        Image.asset(
          'assets/images/Neutral.png',
          width: 43,
        ),
        Image.asset(
          'assets/images/Sad.png',
          width: 43,
        )
      ],
    );
  }
}

class HeadingCard extends StatelessWidget {
  const HeadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            clipBehavior: Clip.none,
            padding: EdgeInsets.only(left: 30, top: 43, bottom: 23),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/FeedbackIcon.png',
                width: 63,
              ),
            ),
          ),
          Container(
            clipBehavior: Clip.none,
            padding: EdgeInsets.only(left: 30, top: 14, bottom: 36, right: 107),
            decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 100,
                child: Text(
                  'Your Thoughts?',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MapContainer extends StatelessWidget {
  const MapContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 294,
      decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Center(
        child: Image.asset(
          'assets/images/Map.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class TextArea extends StatelessWidget {
  const TextArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TextFormField(
        maxLines: 13,
        // The validator receives the text that the user has entered.
        style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 16,
            height: 1),
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14)),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
