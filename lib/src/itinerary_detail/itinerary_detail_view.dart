// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  @override
  Widget build(BuildContext context) {
    final currHeight = MediaQuery.of(context).size.height;
    final currWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF03C3DF),
      body: SingleChildScrollView(
        child: Expanded(
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
                        future: Future.delayed(Duration(seconds: 2)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(
                              color: Colors.cyan,
                            );
                          }
                          return Column(
                            children: [
                              ItineraryDay(itineraryDetails: itineraryDetails)
                            ],
                          );
                        }),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class ItineraryDay extends StatelessWidget {
  const ItineraryDay({
    super.key,
    required this.itineraryDetails,
  });

  final List<ItineraryItemModel>? itineraryDetails;

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
                  'Thursday, 13 June',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'Day 1',
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
              itineraryDetails!.length,
              (index) => Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: ItineraryItem(
                      icon: itineraryDetails![index].icon!,
                      title: itineraryDetails![index].title!,
                      time: itineraryDetails![index].time!,
                      actionLabel: itineraryDetails![index].actionLabel!,
                      details: itineraryDetails![index].details!,
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
      this.details});

  final String title;
  final String time;
  final ImageProvider icon;
  final String actionLabel;
  final List<String>? details;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(9),
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: Colors.black)),
          child: Center(
              child: Image(
            image: icon,
            width: 17,
            fit: BoxFit.contain,
          )),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  Text(time,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6f6f6f))),
                  if (actionLabel != '')
                    Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(right: 70, left: 12),
                                backgroundColor: Color(0xFF03C3DF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            child: Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.start,
                              spacing: 11.5,
                              children: [
                                Align(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Center(
                                        child: Image.asset(
                                      'assets/images/CompassIcon.png',
                                      width: 17,
                                    )),
                                  ),
                                ),
                                Text(actionLabel,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white))
                              ],
                            ))
                      ],
                    ),
                  if (details != null && details!.isNotEmpty)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          ...details!
                              .map((item) => Text(item,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF6f6f6f))))
                              .toList()
                        ])
                ],
              ),
              SizedBox(height: 14.5),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Divider(
                    thickness: 1, color: Color(0xFF707070).withOpacity(0.21)),
              )
            ],
          ),
        )
      ],
    );
  }
}
