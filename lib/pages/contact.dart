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
                return ListView.builder(
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
                    }));
              }
            }),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Détails du Contacts'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Transform.scale(
                        scale: 0.5,
                        child: Image.asset('images/profile.png'),
                      ),
                    ),
                    Text(
                      '${widget.data['firstname']} ${widget.data['lastname']}',
                      style: const TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 45,
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Divider(),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Tél: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            fontSize: 20),
                      ),
                      TextSpan(
                        text: '${widget.data['phone_mobile']}',
                        style:
                            const TextStyle(fontSize: 20, fontFamily: 'Arial'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Email: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            fontSize: 20),
                      ),
                      TextSpan(
                        text: '${widget.data['email']} FCFA',
                        style:
                            const TextStyle(fontSize: 20, fontFamily: 'Arial'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Ville: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            fontSize: 20),
                      ),
                      TextSpan(
                        text: '${widget.data['town']}',
                        style:
                            const TextStyle(fontSize: 20, fontFamily: 'Arial'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Adresse: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            fontSize: 20),
                      ),
                      TextSpan(
                        text: '${widget.data['address']}',
                        style:
                            const TextStyle(fontSize: 20, fontFamily: 'Arial'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Code postale: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            fontSize: 20),
                      ),
                      TextSpan(
                        text: '${widget.data['zip']}',
                        style:
                            const TextStyle(fontSize: 20, fontFamily: 'Arial'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ));
  }
}
