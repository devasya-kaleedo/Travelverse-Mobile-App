import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelverse_mobile_app/src/auth/auth_provider.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final List<Map<String, String>> navItemsList = [
    {
      'title': 'Track My Visa',
      'iconAsset': 'assets/images/NavVisa.png',
      'address': '/my_visa'
    },
    {
      'title': 'View my Itinerary',
      'iconAsset': 'assets/images/NavItinerary.png',
      'address': '/view_my_itineraries'
    },
    {
      'title': 'My Vouchers',
      'iconAsset': 'assets/images/NavVouchers.png',
      'address': '/vouchers'
    },
    {
      'title': 'My Quotes',
      'iconAsset': 'assets/images/NavQuotes.png',
      'address': '/my_quotes'
    },
    {
      'title': 'Share Feedback',
      'iconAsset': 'assets/images/NavFeedback.png',
      'address': '/feedback'
    }
  ];

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(border: Border()),
            padding: EdgeInsets.zero,
            child: Container(
              color: Colors.cyan,
              child: Stack(
                children: [
                  //Positioned(right: 0, child: Text('Logo here')),
                  Positioned(
                      bottom: -16,
                      left: 40,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 32,
                        child: Text('AN'),
                      )),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 31),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                    navItemsList.length,
                    (index) => NavEntry(
                          navItemData: navItemsList[index],
                        )),
                GestureDetector(
                  onTap: () {
                    context.read<AuthProvider>().logout();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Wrap(
                      children: [
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 8,
                          children: [
                            Image.asset('assets/images/NavLogout.png'),
                            Text(
                              'Logout',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Divider()
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NavEntry extends StatelessWidget {
  const NavEntry({super.key, required this.navItemData});
  final Map<String, String> navItemData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, navItemData['address']!);
      },
      child: Container(
        margin: EdgeInsets.only(top: 30),
        child: Wrap(
          children: [
            Wrap(
              direction: Axis.horizontal,
              spacing: 8,
              children: [
                Image.asset(navItemData['iconAsset']!),
                Text(
                  navItemData['title']!,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
