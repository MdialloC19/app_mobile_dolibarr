import 'package:app_mobile_dolibarr/main.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Profile en developpement...',
            style: TextStyle(fontFamily: 'Kanit', fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            child: const Text('Logout'),
          ),
        ]),
      ),
    );
  }
}
