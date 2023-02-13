import 'package:flutter/material.dart';

class EnteteDrawer extends StatefulWidget {
  const EnteteDrawer({super.key});

  @override
  State<EnteteDrawer> createState() => _EnteteDrawerState();
}

class _EnteteDrawerState extends State<EnteteDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      width: double.infinity,
      height: 250,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/profile.jpg'),
              ),
            ),
          ),
          Text(
            'App Dolibarr',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            'mdiallo@esp.sn',
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
