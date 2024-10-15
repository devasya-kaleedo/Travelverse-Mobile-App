// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:travelverse_mobile_app/src/auth/auth_provider.dart';
import 'package:travelverse_mobile_app/src/itinerary_detail/models/itinerary_model.dart';
import 'package:intl/intl.dart';

class ItineraryDetail extends StatelessWidget {
  ItineraryDetail({super.key});
  final List<ItineraryItemModel>? itineraryDetails = [
    ItineraryItemModel(
        icon: AssetImage('assets/images/PlaneIcon.png'),
        title: 'Arrival at Zurich Airport',
        time: '03:00 PM',
        actionLabel: '',
        details: []),
    ItineraryItemModel(
        icon: AssetImage('assets/images/CarIcon.png'),
        title: 'Cab Pick up to Hotel',
        time: '06:00 PM',
        actionLabel: 'Get Directions',
        details: [
          'Taxi Number:ZUR DT 1220',
          'Car:White Honda EV',
          'Contact:4585-9696'
        ]),
    ItineraryItemModel(
        icon: AssetImage('assets/images/CompassIcon.png'),
        title: 'Spend the day exploring Zurich',
        time: '08:00 PM',
        actionLabel: '',
        details: []),
    ItineraryItemModel(
        icon: AssetImage('assets/images/DineIcon.png'),
        title: 'Elmira Fine Dining',
        time: '11:00 PM',
        actionLabel: 'Get Directions',
        details: []),
    ItineraryItemModel(
        icon: AssetImage('assets/images/BedIcon.png'),
        title: 'BVLGARI Hotel',
        time: '02:00 PM',
        actionLabel: '',
        details: []),
  ];

  Future<ItineraryApp?> fetchItinerary(userId, apiToken) async {
    try {
      Map<String, dynamic> queryParams = <String, dynamic>{};

      queryParams['filters[user][id][\$eq]'] = userId.toString();
      queryParams['populate[itinerary_days][populate][day_items]'] = '*';
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
      backgroundColor: Color(0xFF03C3DF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Wrap(
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 47, left: 38),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 24,
                      ),
                      onPressed: () {
                        Navigator.pop(
                            context); // Go back to the previous screen
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 38, bottom: 24, top: 27),
                    constraints: BoxConstraints(minWidth: 100, maxWidth: 155),
                    //decoration: BoxDecoration(color: Colors.red),
                    child: Align(
                      alignment: Alignment(-1, 0),
                      child: Text(
                        'Your Itinerary for Next Trip!',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Center(
                  child: FutureBuilder(
                      future: fetchItinerary(
                          context.read<AuthProvider>().userInfo.id,
                          context.read<AuthProvider>().userInfo.apiToken),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(
                            color: Colors.cyan,
                          );
                        }
                        if (snapshot.data != null) {
                          return Column(
                              children: List.generate(
                                  snapshot.data!.itineraryDays!.length,
                                  (index) => ItineraryDay(
                                        itineraryDetails: itineraryDetails,
                                        dayData: snapshot
                                            .data!.itineraryDays![index],
                                        index: index + 1,
                                      ))
                              // children: [
                              //   ItineraryDay(itineraryDetails: itineraryDetails)
                              // ],
                              );
                        }
                        return Text('no data');
                      }),
                ))
          ],
        ),
      ),
    );
  }
}

class ItineraryDay extends StatelessWidget {
  const ItineraryDay(
      {super.key,
      required this.itineraryDetails,
      required this.dayData,
      required this.index});

  final List<ItineraryItemModel>? itineraryDetails;
  final Map<String, dynamic> dayData;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Wrap(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('EEEE, d MMMM')
                      .format(DateTime.parse(dayData['date'])),
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'Day ${index}',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF6f6f6f),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          ...List.generate(
              dayData['day_items']!.length,
              (index) => Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: ItineraryItem(
                      icon: itineraryDetails![index].icon!,
                      title: itineraryDetails![index].title!,
                      time: itineraryDetails![index].time!,
                      actionLabel: itineraryDetails![index].actionLabel!,
                      details: itineraryDetails![index].details!,
                      dayItem: dayData['day_items'][index],
                    ),
                  ))
        ]);
  }
}

class ItineraryItemModel {
  final ImageProvider? icon;
  final String? title;
  final String? time;
  final String? actionLabel;
  final List<String>? details;

  ItineraryItemModel({
    this.icon,
    this.title,
    this.time,
    this.actionLabel,
    this.details,
  });
}

class ItineraryItem extends StatelessWidget {
  const ItineraryItem(
      {super.key,
      this.time = '',
      this.title = 'title',
      required this.icon,
      this.actionLabel = '',
      this.details,
      required this.dayItem});

  final String title;
  final String time;
  final ImageProvider icon;
  final String actionLabel;
  final List<String>? details;
  final Map<String, dynamic> dayItem;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(),
      tilePadding: EdgeInsets.zero,
      leading: DecoratedBox(
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Image(
            image: icon,
            width: 17,
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: Text(dayItem['title'],
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black)),
      subtitle: Text(time,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6f6f6f))),
      children: [ItineraryApp.getDayItemChildren(dayItem)],
    );
  }
}
