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
      'title': 'My Itinerary',
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
      'title': 'Previous Trips',
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
    String initials = context.read<AuthProvider>().userInfo.first_name[0] +
        context.read<AuthProvider>().userInfo.last_name[0];
    return SafeArea(
      child: Drawer(
          child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 169,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  gradient: LinearGradient(colors: [
                    Colors.cyan,
                    Colors.white,
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          bottom: -15,
                          left: 25,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 32,
                            child: Text(
                              initials,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  color: Color(0xFFA5A5A5),
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                      Positioned(
                        right: 8,
                        top: 30,
                        child: Image.asset(
                          'assets/images/MarkersIcon.png',
                          width: 80,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 33),
                decoration: const BoxDecoration(color: Colors.white),
                child: Center(
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
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
                ),
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: 215,
                child: Center(
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/BaseTextLogo.png',
                        fit: BoxFit.contain,
                        width: 150,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: [
//           Container(
//             decoration: BoxDecoration(border: Border()),
//             padding: EdgeInsets.zero,
//             child: Container(
//               color: Colors.cyan,
//               child: Stack(
//                 children: [
//                   //Positioned(right: 0, child: Text('Logo here')),
//                   Positioned(
//                       bottom: -16,
//                       left: 40,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.white,
//                         radius: 32,
//                         child: Text('AN'),
//                       )),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 31),
//             color: Colors.white,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ...List.generate(
//                     navItemsList.length,
//                     (index) => NavEntry(
//                           navItemData: navItemsList[index],
//                         )),
//                 GestureDetector(
//                   onTap: () {
//                     context.read<AuthProvider>().logout();
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(top: 30),
//                     child: Wrap(
//                       children: [
//                         Wrap(
//                           direction: Axis.horizontal,
//                           spacing: 8,
//                           children: [
//                             Image.asset('assets/images/NavLogout.png'),
//                             Text(
//                               'Logout',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontFamily: 'Poppins',
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500),
//                             )
//                           ],
//                         ),
//                         Divider()
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             color: Colors.white,
//             child: Center(
//               child: Stack(
//                 children: [
//                   Image.asset(
//                     'assets/images/BaseTextLogo.png',
//                     width: 175,
//                     fit: BoxFit.contain,
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

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
