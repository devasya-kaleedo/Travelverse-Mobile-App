import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  const HomeView(
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
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.menu_rounded,
                      color: Colors.black,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Icon(
                            Icons.supervised_user_circle_outlined,
                            color: Colors.black,
                          ),
                          Text(
                            'Abhishek',
                            style: TextStyle(
                                color: Color(0xFF03C3DF), fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                    padding: EdgeInsets.zero,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.16),
                          blurRadius: 5,
                          spreadRadius: 5)
                    ]),
                    child: home_slider(sliderImages: sliderImages)),
              ),
              Container(
                margin: EdgeInsets.all(30),
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color(0xFF00000029),
                      blurRadius: 40,
                      offset: Offset(0, 0))
                ]),
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 275,
                      padding: const EdgeInsets.fromLTRB(30, 17, 30, 17),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return home_nav_button(
                              title: navOptions[index]['title'],
                              subtitle: navOptions[index]['subtitle'],
                            );
                          },
                          separatorBuilder: (_, __) => const Center(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Color(0xFF707070),
                                ),
                              ),
                          itemCount: navOptions.length)),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 50),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Need Help?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("We are available 24x7!",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 24),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 115,
                            height: 39,
                            child: ElevatedButton(
                              onPressed: null,
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Color(0xFF03C3DF)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call_rounded,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Call us',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 55,
          decoration: BoxDecoration(
              color: Color(0xFF03C3DF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Text(
            'Chat with us',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class home_slider extends StatelessWidget {
  const home_slider({
    super.key,
    required this.sliderImages,
  });

  final List<String> sliderImages;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 339,
        height: 170,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        child: CarouselSlider(
          options: CarouselOptions(height: 170.0, viewportFraction: 1),
          items: sliderImages.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: 339,
                  height: 170,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Image.asset(
                    i,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class home_nav_button extends StatelessWidget {
  final String title;
  final String subtitle;
  const home_nav_button({super.key, this.title = '', this.subtitle = ''});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 77,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                subtitle,
                style: TextStyle(
                    color: const Color(0xFF9D9D9D),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [Icon(Icons.arrow_circle_right, color: Color(0xFF03C3DF))],
        )
      ],
    );
  }
}
