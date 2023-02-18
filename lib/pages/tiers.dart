import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataTier extends StatefulWidget {
  const DataTier({super.key});

  @override
  State<DataTier> createState() => _DataTierState();
}

class _DataTierState extends State<DataTier> {
  late Future data;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    data = getTierData();
  }

  Future getTierData() async {
    var response = await http.get(
      Uri.parse(
          'https://ilatouba.with6.dolicloud.com/api/index.php/thirdparties?DOLAPIKEY=qChcqtpDdG9X&output_format=JSON'),
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
        title: const Text("Liste des tiers"),
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
                                  DetailsTiers(data: snapshot.data[i]),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(
                            snapshot.data[i]['name'],
                            style: const TextStyle(
                                fontFamily: 'Kanit', fontSize: 20),
                          ),
                          subtitle: Text(snapshot.data[i]['email']),
                          trailing: Text(snapshot.data[i]['name_alias']),
                        ),
                      );
                    }),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: IconButton(
                      onPressed: () {
                        // Ajoutez votre code pour ajouter un nouveau tier ici
                      },
                      icon: Image.asset('images/add-tier.png'),
                      iconSize: 50,
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

class DetailsTiers extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailsTiers({super.key, required this.data});

  @override
  State<DetailsTiers> createState() => _DetailsTiersState();
}

class _DetailsTiersState extends State<DetailsTiers> {
  Widget textFormat(String text, String data) {
    return Column(children: [
      Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kanit',
                  fontSize: 25),
            ),
            TextSpan(
              text: ': ${widget.data[data]}',
              style: const TextStyle(fontSize: 25, fontFamily: 'Kanit-Regular'),
            ),
          ],
        ),
      )
    ]);
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
        title: const Text('Détails du tiers'),
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
                    height: 150,
                    width: 150,
                    child: Image.asset('images/user.png'),
                  ),
                  Text(
                    '${widget.data['name']}',
                    style: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 35,
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
              ),
              const SizedBox(
                height: 30,
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
                    textFormat('Nom', 'name'),
                    ligne(),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormat('Alias', 'name_alias'),
                    ligne(),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormat('Code client', 'code_client'),
                    ligne(),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormat('Tél', 'phone'),
                    ligne(),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormat('Email', 'email'),
                    ligne(),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormat('Adresse', 'address'),
                    ligne(),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormat('Ville', 'town'),
                    ligne(),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormat('Code postale', 'zip'),
                    ligne(),
                    const SizedBox(height: 16),
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
