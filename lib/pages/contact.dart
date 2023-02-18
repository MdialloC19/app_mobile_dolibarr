import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataContact extends StatefulWidget {
  const DataContact({super.key});

  @override
  State<DataContact> createState() => _DataContactState();
}

class _DataContactState extends State<DataContact> {
  late Future data;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    data = getProductData();
  }

  Future getProductData() async {
    var response = await http.get(
      Uri.parse(
          'https://ilatouba.with6.dolicloud.com/api/index.php/contacts?DOLAPIKEY=qChcqtpDdG9X&output_format=JSON'),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade300,
        title: const Text("Liste des conta"),
        centerTitle: true,
      ),
      body: Card(
        child: FutureBuilder(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Stack(children: [
                  ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: ((context, i) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsContacts(data: snapshot.data[i]),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              (snapshot.data[i]['firstname'] ?? '') +
                                  ' ' +
                                  (snapshot.data[i]['lastname'] ?? ''),
                              style: const TextStyle(
                                  fontFamily: 'Kanit', fontSize: 20),
                            ),
                            subtitle:
                                Text(snapshot.data[i]['phone_mobile'] ?? ''),
                            trailing: Text(snapshot.data[i]['town'] ?? ''),
                          ));
                    }),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: IconButton(
                      onPressed: () {
                        // Ajoutez votre code pour ajouter un nouveau tier ici
                      },
                      icon: Image.asset('images/add-contact.png'),
                      iconSize: 20,
                    ),
                  ),
                ]);
              }
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DetailsContacts extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailsContacts({super.key, required this.data});

  @override
  State<DetailsContacts> createState() => _DetailsContactsState();
}

class _DetailsContactsState extends State<DetailsContacts> {
  Widget textFormat(String text, String data) {
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: text,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontFamily: 'Kanit', fontSize: 25),
          ),
          TextSpan(
            text: ': ${widget.data[data]}',
            style: const TextStyle(fontSize: 25, fontFamily: 'Kanit-Regular'),
          ),
        ],
      ),
    );
  }

  Container ligne() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: const Divider(
        color: Colors.grey,
        thickness: 0.2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade300,
        title: const Text('Détails du Contacts'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade200,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset('images/profile.png'),
                  ),
                  Text(
                    '${widget.data['firstname']} ${widget.data['lastname']}',
                    style: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 40,
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: const Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textFormat('Tél', 'phone_mobile'),
                    ligne(),
                    const SizedBox(
                      height: 30,
                    ),
                    textFormat('Email', 'email'),
                    ligne(),
                    const SizedBox(
                      height: 30,
                    ),
                    textFormat('Ville', 'town'),
                    ligne(),
                    const SizedBox(
                      height: 30,
                    ),
                    textFormat('Adresse', 'address'),
                    ligne(),
                    const SizedBox(
                      height: 30,
                    ),
                    textFormat('Code postal', 'zip'),
                    ligne(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
