import 'package:flutter/material.dart';

import 'my_drawer_header.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Acceuil(),
    );
  }
}

class Acceuil extends StatefulWidget {
  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  var currentPage = MenuDeNavigation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(
          child: Text('Acceuil Dolibarr'),
        ),
      ),
      body: Container(
        child: Center(
          child: Text("Nous allons l'améliorer Acceuil"),
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [EnteteDrawer(), EnteteDrawerList()],
            ),
          ),
        ),
      ),
    );
  }

  Widget EnteteDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        //cela nous permet de montreer la listes des menus
        children: [
          menuItem(1, "Acceuil", Icons.dashboard_outlined,
              currentPage == MenuDeNavigation.accueil ? true : false),
          menuItem(
              2,
              "Gestions Produits Services",
              Icons.dashboard_outlined,
              currentPage == MenuDeNavigation.gestion_produits_services
                  ? true
                  : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.blue[300] : Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  Icons.dashboard_outlined,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Accueil',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum MenuDeNavigation {
  // ignore: constant_identifier_names
  accueil,
  gestion_produits_services,
  messages,
  contacts,
  reglages,
}
