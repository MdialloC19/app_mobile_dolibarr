import 'dart:convert';
import 'package:app_mobile_dolibarr/pages/add_product.dart';
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
        backgroundColor: Colors.cyan.shade300,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddProductForm()));
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                );
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

class DetailsProducts extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailsProducts({super.key, required this.data});

  @override
  State<DetailsProducts> createState() => _DetailsProductsState();
}

class _DetailsProductsState extends State<DetailsProducts> {
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
                  fontSize: 24),
            ),
            TextSpan(
              text: ': ${widget.data[data]}',
              style: const TextStyle(fontSize: 22, fontFamily: 'Kanit-Regular'),
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
        title: const Text('Détails du Products'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade200,
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
                        textFormat('Description', 'description'),
                        ligne(),
                        const SizedBox(
                          height: 30,
                        ),
                        textFormat('Prix(en FCFA)', 'price'),
                        ligne(),
                        const SizedBox(
                          height: 30,
                        ),
                        textFormat('TVA', 'tva_tx'),
                        ligne(),
                        const SizedBox(
                          height: 30,
                        ),
                        textFormat('Limite stock', 'seuil_stock_alerte'),
                        ligne(),
                        const SizedBox(
                          height: 30,
                        ),
                        textFormat('Date création', 'date_creation'),
                        ligne(),
                        const SizedBox(
                          height: 30,
                        ),
                        textFormat('Poids(en g)', 'weight'),
                        ligne(),
                      ]))
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
