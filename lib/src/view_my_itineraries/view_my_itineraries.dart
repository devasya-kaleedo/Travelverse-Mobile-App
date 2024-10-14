// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:travelverse_mobile_app/src/auth/auth_provider.dart';
import 'package:travelverse_mobile_app/src/common/drawer.dart';
import 'package:travelverse_mobile_app/src/itinerary_detail/models/itinerary_model.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class ViewMyItineraries extends StatelessWidget {
  ViewMyItineraries({super.key});

  Future<ItineraryApp?> fetchItinerary(userId, apiToken) async {
    try {
      Map<String, dynamic> queryParams = <String, dynamic>{};

      queryParams['filters[user][id][\$eq]'] = userId.toString();

      Response response = await get(
          Uri.https('dev.strapi.travelverse.in', 'api/itenary-managements',
              queryParams),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $apiToken'});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        if (data['data'].length > 0) {
          ItineraryApp visaApp =
              ItineraryApp.fromStrapiResponse(data['data'][0]);
          return visaApp;
        } else {
          return null;
        }
        // .map((quote) => QuoteApp.fromStrapiResponse(quote))
        // .toList();
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
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
                  Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Image.asset(
                        'assets/images/Hamburger.png',
                        width: 25,
                      ),
                    );
                  }),
                  Wrap(
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
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FutureBuilder(
                future: fetchItinerary(context.read<AuthProvider>().userInfo.id,
                    context.read<AuthProvider>().userInfo.apiToken),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if (snapshot.data == null) {
                      return Text(
                          'You do not have an active itinerary. Plan a trip with Travelverse today !');
                    }
                    ItineraryApp? itineraryApp = snapshot.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: PlaceCard(itineraryApp: itineraryApp!),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: TripStatusCard(),
                        )
                      ],
                    );
                  }
                },
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
                      boldTitle: 'Vouchers',
                      description:
                          'Access and Download all your booking vouchers in one place. Even if you’re offline, you can view or download them at your convenience.',
                      navLink: '/vouchers',
                    ),
                    NavDivider(),
                    NavItem(
                        lightTitle: 'My ',
                        boldTitle: 'Itinerary',
                        description:
                            'View your day- wise itinerary with detailed information on your hotels, driver details, cruise, sightseeings  and vouchers, all in one place.',
                        navLink: '/itinerary_detail'),
                    NavDivider(),
                    NavItem(
                        lightTitle: 'Inclusions ',
                        boldTitle: '& Exclusions',
                        description:
                            'See what’s included and what’s not in your itinerary, so you can enjoy your trip without any surprises.',
                        navLink: '/inclusions_exclusions')
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
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600),
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
      padding: EdgeInsets.only(right: 6, left: 2),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            offset: Offset(5, 5),
            blurRadius: 15)
      ], color: Color(0xFF03C3DF), borderRadius: BorderRadius.circular(10)),
      child: Text(
        'You are on Trip',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 31,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.right,
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    super.key,
    required this.itineraryApp,
  });
  final ItineraryApp itineraryApp;

  String getStartString() {
    var startString =
        DateFormat('d MMM').format(DateTime.parse(itineraryApp.startDate!));
    return startString;
  }

  String getEndString() {
    var startString =
        DateFormat('d MMM').format(DateTime.parse(itineraryApp.endDate!));
    return startString;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      constraints: BoxConstraints(maxHeight: 225),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(5, 5),
                blurRadius: 15)
          ],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage('assets/images/Switzerland.png'),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 14),
            child: Align(
                alignment: Alignment.topRight,
                child: Text('${getStartString()} - ${getEndString()}',
                    style: TextStyle(color: Colors.white))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, bottom: 14),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  itineraryApp.country!,
                  style: TextStyle(color: Colors.white),
                )),
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
                  flex: 6,
                  child: Text(description,
                      style: TextStyle(
                          color: Color(0xFF9D9D9D),
                          fontSize: 10,
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
