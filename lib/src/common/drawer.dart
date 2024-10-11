import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Container(
                color: Colors.cyan,
              )),
          Expanded(
              child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Center(child: Text('Menu items here')),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
