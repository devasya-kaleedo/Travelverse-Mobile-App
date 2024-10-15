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

Future<ItineraryApp?> fetchItinerary(userId, apiToken) async {
  try {
    Map<String, dynamic> queryParams = <String, dynamic>{};

    queryParams['filters[user][id][\$eq]'] = userId.toString();
    queryParams['populate[inclusions][populate]'] = '*';
    queryParams['populate[exclusions][populate]'] = '*';

    Response response = await get(
        Uri.https('dev.strapi.travelverse.in', 'api/itenary-managements',
            queryParams),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $apiToken'});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      if (data['data'].length > 0) {
        ItineraryApp visaApp = ItineraryApp.fromStrapiResponse(data['data'][0]);
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

class InclusionsExclusionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF03C3DF),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      HeaderArea(),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 32, top: 32),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              FutureBuilder(
                                  future: fetchItinerary(
                                      context.read<AuthProvider>().userInfo.id,
                                      context
                                          .read<AuthProvider>()
                                          .userInfo
                                          .apiToken),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting)
                                      return Center(
                                        child: SizedBox(
                                            height: 32,
                                            width: 32,
                                            child: CircularProgressIndicator()),
                                      );
                                    ItineraryApp itineraryApp = snapshot.data!;
                                    List<String> inclusions = itineraryApp
                                        .inclusions!['details']
                                        .split('\n');
                                    List<String> exclusions = itineraryApp
                                        .exclusions!['details']
                                        .split('\n');
                                    return Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Inclusions',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            ...List.generate(
                                                inclusions.length,
                                                (index) => Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8),
                                                      padding: EdgeInsets.only(
                                                          right: 32),
                                                      child: RichText(
                                                          textAlign:
                                                              TextAlign.justify,
                                                          text: TextSpan(
                                                              children: [
                                                                WidgetSpan(
                                                                    child: //       direction: Axis.horizontal,
                                                                        Icon(
                                                                            Icons
                                                                                .adjust,
                                                                            size:
                                                                                15)),
                                                                TextSpan(
                                                                    text: ' '),
                                                                TextSpan(
                                                                    text: inclusions[
                                                                        index],
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400))
                                                              ])),
                                                    )
                                                // Wrap(
                                                //       direction: Axis.horizontal,
                                                //       children: [
                                                //         Icon(Icons.adjust,
                                                //             size: 15),
                                                //         Text(inclusions[index],
                                                //             style: TextStyle(
                                                //                 fontFamily:
                                                //                     'Poppins',
                                                //                 color:
                                                //                     Colors.black,
                                                //                 fontSize: 14,
                                                //                 fontWeight:
                                                //                     FontWeight
                                                //                         .w400)),
                                                //       ],
                                                //     )
                                                ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              'Exclusions',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            ...List.generate(
                                                exclusions.length,
                                                (index) => Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8),
                                                      padding: EdgeInsets.only(
                                                          right: 32),
                                                      child: RichText(
                                                          textAlign:
                                                              TextAlign.justify,
                                                          text: TextSpan(
                                                              children: [
                                                                WidgetSpan(
                                                                    child: //       direction: Axis.horizontal,
                                                                        Icon(
                                                                            Icons
                                                                                .adjust,
                                                                            size:
                                                                                15)),
                                                                TextSpan(
                                                                    text: ' '),
                                                                TextSpan(
                                                                    text: inclusions[
                                                                        index],
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400))
                                                              ])),
                                                    ))
                                          ],
                                        ));
                                  }),
                            ],
                          ),
                        ),
                      )
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(30),
                      //           topRight: Radius.circular(30))),
                      //   padding: EdgeInsets.symmetric(horizontal: 44, vertical: 22),
                      //   child:
                      // FutureBuilder(
                      //       future: fetchItinerary(
                      //           context.read<AuthProvider>().userInfo.id,
                      //           context.read<AuthProvider>().userInfo.apiToken),
                      //       builder: (context, snapshot) {
                      //         if (snapshot.connectionState ==
                      //             ConnectionState.waiting)
                      //           return Center(
                      //             child: SizedBox(
                      //                 height: 32,
                      //                 width: 32,
                      //                 child: CircularProgressIndicator()),
                      //           );
                      //         ItineraryApp itineraryApp = snapshot.data!;
                      //         List<String> inclusions =
                      //             itineraryApp.inclusions!['details'].split('\n');
                      //         List<String> exclusions =
                      //             itineraryApp.exclusions!['details'].split('\n');
                      //         return Align(
                      //             alignment: Alignment.topLeft,
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   'Inclusions',
                      //                   style: TextStyle(
                      //                       fontFamily: 'Poppins',
                      //                       color: Colors.black,
                      //                       fontSize: 24,
                      //                       fontWeight: FontWeight.w600),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 8,
                      //                 ),
                      //                 ...List.generate(
                      //                     inclusions.length,
                      //                     (index) => Row(
                      //                           children: [
                      //                             Icon(Icons.adjust, size: 15),
                      //                             SizedBox(
                      //                               width: 10,
                      //                             ),
                      //                             Text(inclusions[index],
                      //                                 style: TextStyle(
                      //                                     fontFamily: 'Poppins',
                      //                                     color: Colors.black,
                      //                                     fontSize: 14,
                      //                                     fontWeight:
                      //                                         FontWeight.w400)),
                      //                           ],
                      //                         )),
                      //                 SizedBox(
                      //                   height: 16,
                      //                 ),
                      //                 Text(
                      //                   'Exclusions',
                      //                   style: TextStyle(
                      //                       fontFamily: 'Poppins',
                      //                       color: Colors.black,
                      //                       fontSize: 24,
                      //                       fontWeight: FontWeight.w600),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 8,
                      //                 ),
                      //                 ...List.generate(
                      //                     exclusions.length,
                      //                     (index) => Row(
                      //                           children: [
                      //                             Icon(Icons.adjust, size: 15),
                      //                             SizedBox(
                      //                               width: 10,
                      //                             ),
                      //                             Text(exclusions[index],
                      //                                 style: TextStyle(
                      //                                     color: Colors.black,
                      //                                     fontFamily: 'Poppins',
                      //                                     fontSize: 14,
                      //                                     fontWeight:
                      //                                         FontWeight.w400)),
                      //                           ],
                      //                         ))
                      //               ],
                      //             ));
                      //       }),
                      // )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HeaderArea extends StatelessWidget {
  const HeaderArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF03C3DF), Color(0xFFFEFEFE)],
              stops: [0, 0.95],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
      padding: EdgeInsets.only(left: 38, top: 47),
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Image.asset(
              'assets/images/BackIconVisa.png',
              width: 24,
              fit: BoxFit.contain,
            ),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
          SizedBox(
            height: 27,
          ),
          SizedBox(
            width: 155,
            child: Text(
              'Inclusions & Exclusions',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
