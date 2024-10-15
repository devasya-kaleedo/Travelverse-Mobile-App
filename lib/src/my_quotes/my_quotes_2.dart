import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:travelverse_mobile_app/src/auth/auth_provider.dart';
import 'package:travelverse_mobile_app/src/my_quotes/quote_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MyQuotes2 extends StatefulWidget {
  @override
  _MyQuotes2State createState() => _MyQuotes2State();
}

class _MyQuotes2State extends State<MyQuotes2> {
  Future<List<QuoteApp>?> fetchQuotationsByUserId(userId, apiToken) async {
    try {
      Map<String, dynamic> queryParams = <String, dynamic>{};
      queryParams['populate'] = '*';
      queryParams['filters[user][id][\$eq]'] = userId.toString();
      Response response = await get(
          Uri.https('dev.strapi.travelverse.in', 'api/quotations', queryParams),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $apiToken'});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        List<QuoteApp> quotations = <QuoteApp>[];
        List quotationsData = data['data'];
        quotations = quotationsData
            .map((quote) => QuoteApp.fromStrapiResponse(quote))
            .toList();
        print(quotationsData);
        // .map((quote) => QuoteApp.fromStrapiResponse(quote))
        // .toList();
        return quotations;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currHeight = MediaQuery.of(context).size.height;
    final currWidth = MediaQuery.of(context).size.width;

    late Future<List<QuoteApp>> quotations;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        HeaderArea(),
                        Container(
                          //constraints: BoxConstraints.expand(),
                          decoration: BoxDecoration(color: Colors.white),
                          margin: EdgeInsets.only(top: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                  future: fetchQuotationsByUserId(
                                      context.read<AuthProvider>().userInfo.id,
                                      context
                                          .read<AuthProvider>()
                                          .userInfo
                                          .apiToken),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.cyan,
                                      );
                                    } else {
                                      List<QuoteApp> quotationsList =
                                          snapshot.data;
                                      //var quotationsCardList = quotationsList.map((quotation)=>QuoteCard()).toList();
                                      return Column(
                                        children: List.generate(
                                            quotationsList.length, (index) {
                                          return Container(
                                            margin: EdgeInsets.only(top: 16),
                                            child: QuoteCard(
                                                title: 'Quote ${index + 1}',
                                                country: quotationsList[index]
                                                    .country,
                                                dateString: '14th June 2024',
                                                quoteApp:
                                                    quotationsList[index]),
                                          );
                                        }),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 99, top: 86),
                      child: Footer(),
                    )
                  ]),
            ),
          );
        }),
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
                Navigator.pop(context); // Go back to the previous screen
              },
            ),
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.currHeight,
    required this.currWidth,
  });

  final double currHeight;
  final double currWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        child: Align(
          alignment: Alignment(0, 2),
          child: Image.asset(
            'assets/images/Map.png',
            fit: BoxFit.cover,
          ),
        ),
        //height: currHeight * 0.33,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: [0, 1],
                colors: [Color(0xFF03C3DF), Colors.white],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      Align(
        alignment: Alignment(-0.5, 0.5),
        child: Container(
          height: 0.27 * currHeight,
          width: 0.55 * currWidth,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 14, top: 16),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset('assets/images/FileIcon.png',
                          fit: BoxFit.contain, width: 80))),
              Container(
                padding: EdgeInsets.fromLTRB(24, 18, 14, 36),
                //width: 200,
                decoration: BoxDecoration(
                    color: Color(0xFFEAFAFC),
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
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment(-0.6, 0.85),
        child: Container(
          child: Transform(
              transform: Matrix4.rotationZ(1.56),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/BlueArrow.png',
                fit: BoxFit.contain,
                width: 60,
              )),
        ),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 100,
          ),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      )
    ]);
  }
}

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(left: 44),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ElevatedButton(
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
              backgroundColor: Color(0xFFE8E8E8),
              padding: EdgeInsets.symmetric(vertical: 9, horizontal: 20),
              fixedSize: Size(98, 33),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
        ),
      ),
    );
  }
}

class QuoteCard extends StatelessWidget {
  const QuoteCard(
      {super.key,
      required this.title,
      required this.country,
      required this.dateString,
      required this.quoteApp});
  final String title;
  final String country;
  final String dateString;
  final QuoteApp quoteApp;

  Future openQuote() async {
    await openFile(quoteApp.quote['url'],
        '${quoteApp.quote['name']}${quoteApp.quote['ext']}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await openQuote();
      },
      child: Container(
        alignment: Alignment.topCenter,
        //width: MediaQuery.of(context).size.width,
        //padding: EdgeInsets.symmetric(horizontal: 34),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        decoration: BoxDecoration(
          color: Colors.white,
          //border: Border.all(color: Colors.yellow),
        ),
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.start,
          spacing: 16,
          children: [
            Container(
              //width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints.tight(Size(323, 68)),
              decoration: BoxDecoration(
                  color: Color(0xFF03C3DF),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    children: [
                      SizedBox(
                        width: 28,
                        child: Image.asset(
                          'assets/images/PDFIcon.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '$country | $dateString',
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
                  Image.asset(
                    'assets/images/DownArrow.png',
                    width: 30,
                    fit: BoxFit.contain,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> checkAndRequestStoragePermission() async {
  var status = await Permission.manageExternalStorage.status;
  if (!status.isGranted) {
    status = await Permission.manageExternalStorage.request();
  }
  return status.isGranted;
}

Future openFile(String url, String fileName) async {
  final file = await downloadFile(url, fileName);
  if (file == null) return;
  OpenFile.open(file.path);
}

Future<File?> downloadFile(String url, String name) async {
  if (!kIsWeb) {
    final hasPermission = await checkAndRequestStoragePermission();
    if (!hasPermission) {
      throw Exception(
          'Storage permission needed for downloading and viewing files.');
    }
  }
  final appStorage = await getExternalStorageDirectory();
  final file = File('${appStorage?.absolute.path}/$name');
  try {
    final response = await dio.Dio().get(url,
        options: dio.Options(
            responseType: dio.ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: Duration.zero));
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    return file;
  } catch (e) {
    print(e.toString());
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
              colors: [Colors.cyan, Color(0xFF95DCF0)],
              stops: [0, 0.8],
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
            padding: EdgeInsets.only(left: 24, top: 36, bottom: 23),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/FileIcon.png',
                width: 90,
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
                  'My Quotes',
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
