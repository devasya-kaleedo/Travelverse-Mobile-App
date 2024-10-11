import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView2 extends StatelessWidget {
  const HomeView2(
      {super.key,
      this.sliderImages = const [
        'assets/images/home-slider-1.webp',
        'assets/images/home-slider-2.jpg',
        'assets/images/home-slider-3.jpg'
      ],
      this.navOptions = const <Map>[
        {'title': 'My Quotes', 'subtitle': 'see quotations sent to you'},
        {'title': 'Track My Visa', 'subtitle': 'check visa application status'},
        {'title': 'My Itinerary', 'subtitle': 'browse your travel plan'}
      ]});
  final List navOptions;
  static const routeName = '/home';
  final List<String> sliderImages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 56,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            //border: Border.all(color: Color(0xFF03C3DF))
          ),
          //padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(34, 0, 41, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  //border: Border.all(color: Color(0xFF03C3DF))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset('assets/images/Hamburger.svg',
                        width: 25, height: 25),
                    SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/images/ProfileIcon.png'))
                  ],
                ),
              ),
              Container(
                key: Key('slider-container'),
                padding: EdgeInsets.fromLTRB(24, 0, 26, 0),
                margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    //: Border.all(color: Color(0xFF03C3DF)),
                    borderRadius: BorderRadius.circular(25)),
                child: CarouselSlider(
                  items: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/images/Banner1.png',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                  options: CarouselOptions(viewportFraction: 1, height: 170),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 28),
                padding: EdgeInsets.only(left: 24, right: 24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    //border: Border.all(color: Color(0xFF03C3DF)),
                    borderRadius: BorderRadius.circular(25)),
                child: DecoratedBox(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.16),
                        offset: Offset(5, 5),
                        blurRadius: 30)
                  ]),
                  child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22.5, 13, 22.5, 18),
                        child: Column(
                          children: [
                            Row(children: [
                              Text(
                                'My ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                'Quotes',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 32,
                                  width: 200,
                                  child: Text(
                                    'Lorem ipsum dolor set amet consectetur adipiscing elit,',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF9D9D9D)),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/BlueArrow.png',
                                  width: 25,
                                )
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: Divider(
                                  thickness: 1,
                                  color: Color(0xFF707070).withOpacity(0.21),
                                )),
                            Row(children: [
                              Text(
                                'Track ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                'My Visa',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 32,
                                  width: 200,
                                  child: Text(
                                    'Lorem ipsum dolor set amet consectetur adipiscing elit,',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF9D9D9D)),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/BlueArrow.png',
                                  width: 25,
                                )
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: Divider(
                                  thickness: 1,
                                  color: Color(0xFF707070).withOpacity(0.21),
                                )),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/view_my_itineraries');
                              },
                              child: Row(children: [
                                Text(
                                  'View ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  'My Itinerary',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )
                              ]),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 32,
                                  width: 200,
                                  child: Text(
                                    'Lorem ipsum dolor set amet consectetur adipiscing elit,',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF9D9D9D)),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/BlueArrow.png',
                                  width: 25,
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                //margin: EdgeInsets.only(top: 28),
                //padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    //border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 39, top: 45),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Color(0xFF03C3DF)),
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Need Help?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'We are available 24x7!',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 24),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF03C3DF),
                                      padding: EdgeInsets.all(0),
                                      fixedSize: Size(115, 39),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/PhoneIcon.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Text(
                                        'Call us',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Align(
                            alignment: Alignment(1.7, 0),
                            child: Image.asset(
                                'assets/images/DottedAeroplane.png',
                                width: 164,
                                height: 160),
                          ),
                        ),
                      ),
                    ]),
              )
            ],
          )),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color(0xFF03C3DF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        height: 50,
        alignment: Alignment.center,
        child: Text(
          'Chat with us',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
