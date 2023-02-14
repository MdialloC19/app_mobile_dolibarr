import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  //StatelessWidget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Home Page Scaffold
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Home page"),
          const SizedBox(
            height: 50,
          ),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app),
            label: const Text("Logout"),
          ),
        ],
      )),
    );
  }
}
