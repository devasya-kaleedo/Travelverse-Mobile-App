import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyQuotesView extends StatelessWidget {
  const MyQuotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Color(0xFF03C3DF))),
          child: Wrap(
            direction: Axis.vertical,
            children: [
              Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height / 2,
                    minWidth: MediaQuery.of(context).size.width),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF03C3DF), // Start color
                            Colors.white, // End color
                          ],
                          begin: Alignment
                              .bottomCenter, // Gradient start alignment
                          end: Alignment.topCenter,
                          // Gradient end alignment
                        ),
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(
                            12), // Optional: rounded corners
                      ),
                      child: Image.asset(
                        'assets/images/Map.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Positioned(
                        top: 130,
                        left: 40,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(14, 20, 0, 10),
                                    child: Image.asset(
                                        'assets/images/FileIcon.png')),
                                Container(
                                  padding: EdgeInsets.fromLTRB(24, 18, 14, 36),
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 149, 180, 184),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Text(
                                    'Quotes for your next trip!',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                )
                              ]),
                        )),
                    Positioned(
                        top: 320,
                        left: 60,
                        child: Transform(
                            transform: Matrix4.rotationZ(1.56),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/BlueArrow.png',
                              width: 70,
                            )))
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 34),
                constraints:
                    BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.yellow)),
                child: Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.start,
                  spacing: 16,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints.tight(Size(323, 68)),
                      decoration: BoxDecoration(
                          color: Color(0xFF03C3DF),
                          borderRadius: BorderRadius.circular(20)),
                      padding:
                          EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            children: [
                              Image.asset(
                                'assets/images/PDFIcon.png',
                                width: 28,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Quote 1',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Thailand | 16th June 2024',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          ),
                          Image.asset('assets/images/DownArrow.png')
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints.tight(Size(323, 68)),
                      decoration: BoxDecoration(
                          color: Color(0xFF03C3DF),
                          borderRadius: BorderRadius.circular(20)),
                      padding:
                          EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            children: [
                              Image.asset(
                                'assets/images/PDFIcon.png',
                                width: 28,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Quote 2',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Thailand | 18th June 2024',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          ),
                          Image.asset('assets/images/DownArrow.png')
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints.tight(Size(323, 68)),
                      decoration: BoxDecoration(
                          color: Color(0xFF03C3DF),
                          borderRadius: BorderRadius.circular(20)),
                      padding:
                          EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            children: [
                              Image.asset(
                                'assets/images/PDFIcon.png',
                                width: 28,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Quote 3',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Thailand | 20th June 2024',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          ),
                          Image.asset('assets/images/DownArrow.png')
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
