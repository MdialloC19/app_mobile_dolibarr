import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProduct extends StatefulWidget {
  const DataProduct({super.key});

  @override
  State<DataProduct> createState() => _DataProductState();
}

class _DataProductState extends State<DataProduct> {
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
          'https://ilatouba.with6.dolicloud.com/api/index.php/products?DOLAPIKEY=qChcqtpDdG9X&output_format=JSON'),
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
        title: const Text("Liste des produits"),
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
                return Stack(
                  children: [
                    ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: ((context, i) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsProducts(data: snapshot.data[i]),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              snapshot.data[i]['label'],
                              style: const TextStyle(
                                  fontFamily: 'Kanit', fontSize: 20),
                            ),
                            subtitle: Text(snapshot.data[i]['description']),
                            trailing: Text(snapshot.data[i]['price']),
                          ),
                        );
                      }),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: FloatingActionButton(
                        onPressed: () {
                          // Ajoutez votre code pour ajouter un nouveau tier ici
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}

class DetailsProducts extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailsProducts({super.key, required this.data});

  @override
  State<DetailsProducts> createState() => _DetailsProductsState();
}

class _DetailsProductsState extends State<DetailsProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du Products'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '${widget.data['label']}',
                style: const TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 50,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: 'Description: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.data['description']}',
                    style: const TextStyle(fontSize: 20, fontFamily: 'Arial'),
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
                    text: 'Prix: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.data['price']} FCFA',
                    style: const TextStyle(fontSize: 20, fontFamily: 'Arial'),
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
                    text: 'TVA: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.data['tva_tx']}',
                    style: const TextStyle(fontSize: 20, fontFamily: 'Arial'),
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
                    text: 'Limite stock: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.data['seuil_stock_alerte']}',
                    style: const TextStyle(fontSize: 20, fontFamily: 'Arial'),
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
                    text: 'Date création: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.data['date_creation']}',
                    style: const TextStyle(fontSize: 20, fontFamily: 'Arial'),
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
                    text: 'Poids: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.data['weight']} g',
                    style: const TextStyle(fontSize: 20, fontFamily: 'Arial'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
