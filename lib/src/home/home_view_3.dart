// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:travelverse_mobile_app/src/auth/auth_provider.dart';

class HomeView3 extends StatelessWidget {
  HomeView3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.symmetric(horizontal: 34),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/Hamburger.png',
                    width: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AuthProvider>().logout();
                    },
                    child: Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ProfileIcon.png',
                          width: 25,
                        ),
                        Text(
                          context.read<AuthProvider>().userInfo.first_name,
                          style: TextStyle(color: Color(0xFF03C3DF)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Banner(),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              margin: EdgeInsets.only(top: 11),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.16),
                          offset: Offset(5, 5),
                          blurRadius: 30)
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NavItem(
                      lightTitle: 'My ',
                      boldTitle: 'Quotes',
                      description:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                      navLink: '/my_quotes',
                    ),
                    NavDivider(),
                    NavItem(
                        lightTitle: 'Track ',
                        boldTitle: 'My Visa',
                        description:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                        navLink: '/my_visa'),
                    NavDivider(),
                    NavItem(
                        lightTitle: 'View ',
                        boldTitle: 'My Itinerary',
                        description:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                        navLink: '/view_my_itineraries')
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 32),
              padding: EdgeInsets.only(left: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Need Help?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                  Text('We are available 24x7!',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500)),
                  Container(
                      margin: EdgeInsets.only(top: 24), child: CallUsButton()),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Color(0xFF03C3DF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Center(
            child: Text(
          'Chat with us',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}

class CallUsButton extends StatelessWidget {
  const CallUsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF03C3DF),
            padding: EdgeInsets.all(0),
            fixedSize: Size(115, 39),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        ));
  }
}

class NavDivider extends StatelessWidget {
  const NavDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
            child: Divider(
          color: Color(0xFF707070).withOpacity(0.21),
        )));
  }
}

class TripStatusCard extends StatelessWidget {
  const TripStatusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 221,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            offset: Offset(5, 5),
            blurRadius: 15)
      ], color: Color(0xFF03C3DF), borderRadius: BorderRadius.circular(10)),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      constraints: BoxConstraints(maxHeight: 170),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(5, 5),
                blurRadius: 15)
          ],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage('assets/images/Banner1.png'),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 23),
            margin: EdgeInsets.only(top: 32),
            child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 155),
                  child: Text(
                    'Explore the World',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 27,
                        fontWeight: FontWeight.w600),
                  ),
                )),
          ),
          Container(
            padding: const EdgeInsets.only(left: 23),
            margin: EdgeInsets.only(top: 7),
            child: Align(alignment: Alignment.centerLeft, child: Text('with')),
          ),
          Container(
            padding: const EdgeInsets.only(left: 23),
            child: Image.asset(
              'assets/images/BaseTextLogo.png',
              width: 116,
            ),
          )
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem(
      {super.key,
      required this.lightTitle,
      required this.boldTitle,
      required this.description,
      required this.navLink});
  final String lightTitle;
  final String boldTitle;
  final String description;
  final String navLink;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.pushNamed(context, navLink);
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: [
                Text(
                  lightTitle,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),
                Text(boldTitle,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(description,
                      style: TextStyle(
                          color: Color(0xFF9D9D9D),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600)),
                ),
                Flexible(
                  child: Image.asset(
                    'assets/images/BlueArrow.png',
                    width: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
