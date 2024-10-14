// ignore_for_file: prefer_const_literals_to_create_immutables, sort_child_properties_last

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
import 'package:travelverse_mobile_app/src/login/login_form.dart';

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
        ItineraryApp itineraryApp =
            ItineraryApp.fromStrapiResponse(data['data'][0]);
        return itineraryApp;
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

class VouchersView extends StatelessWidget {
  VouchersView({super.key});

  @override
  Widget build(BuildContext context) {
    final currHeight = MediaQuery.of(context).size.height;
    final currWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              height: currHeight * 0.11,
              padding: EdgeInsets.only(top: 35, left: 38),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(
                            context); // Go back to the previous screen
                      },
                      child: Image.asset(
                        'assets/images/BackIconVisa.png',
                        width: 24,
                        fit: BoxFit.contain,
                      ))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: currHeight * 0.4,
              width: currWidth,
              child: Image.asset(
                'assets/images/BlueWave.png',
                fit: BoxFit.fill,
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 35),
                  padding: EdgeInsets.symmetric(horizontal: 44),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Center(
                    child: FutureBuilder(
                        future: fetchItinerary(
                            context.read<AuthProvider>().userInfo.id,
                            context.read<AuthProvider>().userInfo.apiToken),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return CircularProgressIndicator();
                          else {
                            ItineraryApp? itineraryApp = snapshot.data;
                            return MainContent(
                              items: itineraryApp?.discounts_complimentaries,
                            );
                          }
                        }),
                  ),
                ),
                Positioned(
                  top: -245,
                  left: 113,
                  child: Image.asset('assets/images/Gift.png',
                      width: 163, fit: BoxFit.contain),
                ),
                Positioned(
                  right: 40,
                  top: 50,
                  child: Image.asset(
                    'assets/images/Sparkle.png',
                    width: 52,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 18,
            )
          ],
        ),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({super.key, this.items});

  final String? items;

  @override
  Widget build(BuildContext context) {
    List<String> itemList = List.empty();

    if (items != null) {
      itemList = items!.split('\n');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'From us, to you',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 12,
        ),
        ...List.generate(
            itemList.length,
            (index) => ItemView(
                  title: itemList[index],
                )),
        SizedBox(
          height: 80,
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            'Need Help?',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF989898),
              padding: EdgeInsets.symmetric(vertical: 9, horizontal: 20),
              fixedSize: Size(98, 33),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
        )
      ],
    );
  }
}

class ItemView extends StatelessWidget {
  const ItemView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300),
          ),
        ),
        // Flexible(
        //   flex: 2,
        //   child: Image.asset(
        //     'assets/images/Sparkle.png',
        //     width: 52,
        //     fit: BoxFit.contain,
        //   ),
        // )
      ],
    );
  }
}
