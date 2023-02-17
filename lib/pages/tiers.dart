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
                return ListView.builder(
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
                );
              }
            }),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du tiers'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Transform.scale(
                scale: 0.5,
                child: Image.asset('images/user.png'),
              ),
            ),
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: 'Nom: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.data['name']}',
                    style: const TextStyle(fontSize: 15, fontFamily: 'Arial'),
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
                    text: 'Alias: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.data['name_alias']}',
                    style: const TextStyle(fontSize: 15, fontFamily: 'Arial'),
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
                    text: 'Code client: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.data['code_client']}',
                    style: const TextStyle(fontSize: 15, fontFamily: 'Arial'),
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
                    text: 'Tél: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.data['phone']}',
                    style: const TextStyle(fontSize: 15, fontFamily: 'Arial'),
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
                    text: 'Mail: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.data['email']}',
                    style: const TextStyle(fontSize: 15, fontFamily: 'Arial'),
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
                    style: const TextStyle(fontSize: 15, fontFamily: 'Arial'),
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
                    style: const TextStyle(fontSize: 15, fontFamily: 'Arial'),
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
                    text: 'Code postal: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.data['zip']}',
                    style: const TextStyle(fontSize: 15, fontFamily: 'Arial'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
