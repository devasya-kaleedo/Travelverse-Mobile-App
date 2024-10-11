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
                Expanded(
                  flex: 219,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Center(
                            child: Column(
                          children: [
                            Expanded(
                                flex: 7,
                                child: Container(
                                  child: Center(
                                      child: Image.asset(
                                    'assets/images/Map.png',
                                    fit: BoxFit.fill,
                                  )),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF03C3DF),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                )),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  color: Colors.white,
                                ))
                          ],
                        )),
                      ),
                      Positioned(
                        left: 38,
                        bottom: 70,
                        child: IntrinsicWidth(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                clipBehavior: Clip.none,
                                padding: EdgeInsets.only(
                                    left: 30, top: 43, bottom: 23),
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
                                padding: EdgeInsets.only(
                                    left: 30, top: 14, bottom: 36, right: 107),
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
                                      'Your Visa Status',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 32,
                          left: 53,
                          child: Image.asset(
                            'assets/images/DownArrowBlue.png',
                            fit: BoxFit.contain,
                            width: 72,
                          ))
                    ],
                  ),
                ),
                Expanded(
                    flex: 281,
                    child: FutureBuilder(
                      future: fetchVisaApplication(
                          context.read<AuthProvider>().userInfo.email,
                          context.read<AuthProvider>().userInfo.apiToken),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
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
      child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFE3F6F9),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 24, top: 22, bottom: 27),
                  decoration: BoxDecoration(
                      color: Color(0xFF03C3DF),
                      borderRadius: BorderRadius.circular(20)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
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
                        Container(
                          margin: EdgeInsets.only(top: 16.5),
                          child: Wrap(direction: Axis.vertical, children: [
                            Text(
                              'Date Applied',
                              style: TextStyle(
                                  color: Color(0xFF177689),
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              visaApp.applicationDate ?? '',
                              style: TextStyle(
                                  color: Color(0xFF177689),
                                  fontFamily: 'Poppins',
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8.5),
                          child: Wrap(direction: Axis.vertical, children: [
                            Text(
                              'Estimated Date of Decision',
                              style: TextStyle(
                                  color: Color(0xFF177689),
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              visaApp.expectedDate ?? '',
                              style: TextStyle(
                                  color: Color(0xFF177689),
                                  fontFamily: 'Poppins',
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                        )
                      ],
                    ),
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
                  padding:
                      EdgeInsets.only(left: 24, top: 22, bottom: 22, right: 24),
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
                                  fontSize: 10,
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
                )
              ],
            ),
          )),
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
