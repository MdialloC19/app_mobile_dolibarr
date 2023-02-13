import 'package:flutter/material.dart';
import 'accueil_page.dart';
import 'contacts.dart';
import 'my_drawer_header.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Accueil(),
    );
  }
}

class Accueil extends StatefulWidget {
  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  var currentPage = MenuDeNavigation.accueil;
  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == MenuDeNavigation.accueil) {
      container = AccueilPage();
    } else if (currentPage == MenuDeNavigation.gestion_produits_services) {
      container = ContactsPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(
          child: Text('Accueil Dolibarr'),
        ),
      ),
      body: container,
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
          menuItem(1, "Accueil", Icons.dashboard_outlined,
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
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = MenuDeNavigation.accueil;
            } else if (id == 2) {
              currentPage = MenuDeNavigation.gestion_produits_services;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
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
