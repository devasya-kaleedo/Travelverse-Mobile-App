// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:travelverse_mobile_app/src/auth/auth_provider.dart';
import 'package:travelverse_mobile_app/src/my_visa/visa_model.dart';
import 'package:http/http.dart';
import 'dart:convert';

class VisaView extends StatelessWidget {
  VisaView({super.key});

  Future<VisaApp?> fetchVisaApplication(userEmail, apiToken) async {
    try {
      Map<String, dynamic> queryParams = <String, dynamic>{};
      queryParams['populate'] = '*';
      queryParams['filters[status][\$ne]'] = 'Not applied';
      queryParams['filters[email][\$eq]'] = userEmail;
      queryParams['sort[0]'] = 'createdAt:desc';
      queryParams['pagination[limit]'] = '1';
      Response response = await get(
          Uri.https(
              'dev.strapi.travelverse.in', 'api/visa-inquiries', queryParams),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $apiToken'});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        if (data['data'].length > 0) {
          VisaApp visaApp = VisaApp.fromStrapiResponse(data['data'][0]);
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
    final currHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints(maxHeight: currHeight),
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
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
                          bottom: 0,
                          left: 53,
                          child: Image.asset(
                            'assets/images/DownArrowBlue.png',
                            width: 60,
                            fit: BoxFit.contain,
                          )),
                      Positioned(
                        left: 34,
                        top: 36,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.pop(
                                context); // Go back to the previous screen
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Expanded(
                    child: FutureBuilder(
                  future: fetchVisaApplication(
                      context.read<AuthProvider>().userInfo.email,
                      context.read<AuthProvider>().userInfo.apiToken),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.data != null) {
                        VisaApp visaApp = snapshot.data!;
                        return VisaInfoCard(
                          visaApp: visaApp,
                        );
                      } else {
                        return Text(
                            'You do not have any active visa applications');
                      }
                    }
                  },
                ))
              ]),
        ),
      ),
    );
  }
}

class VisaInfoCard extends StatelessWidget {
  const VisaInfoCard({super.key, required this.visaApp});

  final VisaApp visaApp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 44),
      decoration: BoxDecoration(
          color: Colors.white24, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFE3F6F9),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 22, bottom: 27),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.cyan, Color(0xFF95DCF0)],
                              stops: [0, 0.8],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.loose,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24),
                                child: Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      'Reference No.',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      visaApp.visaReference!,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 16),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      VerticalDivider(
                                        color: Colors.white,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            //margin: EdgeInsets.only(top: 16.5),
                                            child: Wrap(
                                                direction: Axis.vertical,
                                                children: [
                                                  Text(
                                                    'Date Applied',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF177689),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    visaApp.applicationDate ??
                                                        '',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF177689),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ]),
                                          ),
                                          Container(
                                            //margin: EdgeInsets.only(top: 8.5),
                                            child: Wrap(
                                                direction: Axis.vertical,
                                                children: [
                                                  Text(
                                                    'Estimated Date of Decision',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF177689),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    visaApp.expectedDate ?? '',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF177689),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            right: 10,
                            bottom: -30,
                            child: Image.asset(
                              'assets/images/AeroplaneWhite.png',
                              width: 100,
                              fit: BoxFit.contain,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 24, top: 22, bottom: 22),
                      decoration: BoxDecoration(
                          color: Color(0xFFCBEEF4),
                          borderRadius: BorderRadius.circular(20)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              'Pax Applied For',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(visaApp.pax!.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 24, top: 22, bottom: 22, right: 24),
                      decoration: BoxDecoration(
                          color: Color(0xFFE3F6F9),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  'Status',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(visaApp.status!,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            SizedBox(
                              width: 23.5,
                              child: Image.asset(
                                getVisaStatusAsset(visaApp.status!),
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          if (visaApp.status! == 'Completed')
            Container(
              margin: EdgeInsets.only(top: 38),
              color: Colors.white,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/DownArrowBlue.png',
                        width: 15,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        'Download Now',
                        style: TextStyle(
                            color: Colors.cyan,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.cyan,
                            decorationThickness: 4,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 10),
                      ),
                    ],
                  )),
            )
        ],
      ),
    );
  }

  String getVisaStatusAsset(String status) {
    switch (status) {
      case 'Applied':
      case 'In Processing':
        return 'assets/images/Pending.png';
      case 'Completed':
        return 'assets/images/Approved.png';
      case 'Rejected':
        return 'assets/images/Rejected.png';
    }
    return '';
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
          gradient: LinearGradient(
              colors: [Colors.cyan, Colors.white],
              stops: [0, 0.95],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Center(
        child: Image.asset(
          'assets/images/Map.png',
          width: 500,
          fit: BoxFit.cover,
        ),
      ),
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
            padding: EdgeInsets.only(left: 24, top: 42, bottom: 23),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/VisaIcon.png',
                width: 63,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            clipBehavior: Clip.none,
            padding: EdgeInsets.only(left: 30, top: 14, bottom: 36, right: 90),
            decoration: BoxDecoration(
                color: Color(0xFFEAFAFC),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 100,
                child: Text(
                  'Your Visa Status',
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
