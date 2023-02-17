// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '/home_page.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //Material App
      debugShowCheckedModeBanner: false,
      title: "Login App",
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  //StateFullWidget

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var loginController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Scaffold
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.lightBlueAccent,
        child: Stack(
          children: <Widget>[
            const Align(
              alignment: Alignment.bottomRight,
              heightFactor: 0.5,
              widthFactor: 0.5,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(200.0)),
                color: Color.fromRGBO(255, 255, 255, 0.4),
                child: SizedBox(
                  width: 400,
                  height: 400,
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 400,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Material(
                      elevation: 10.0,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "images/dolibarr.jpeg",
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    Form(
                      child: TextFormField(
                        controller: loginController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Username",
                          prefixIcon: const Icon(Icons.person),
                          iconColor: Colors.indigo,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 88, 88, 88),
                        ),
                      ),
                      // child: InputField(
                      //     //Calling inputField  class
                      //     const Icon(
                      //       Icons.person,
                      //       color: Colors.white,
                      //     ),
                      //     "Username"),
                    ),
                    Form(
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          iconColor: Colors.indigo,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 88, 88, 88),
                        ),
                      ),
                      // child: InputField(
                      //     const Icon(
                      //       Icons.lock,
                      //       color: Colors.white,
                      //     ),
                      //     "Password"),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          foregroundColor: Colors.indigo,
                        ),
                        onPressed: () {
                          login();
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    if (passwordController.text.isNotEmpty && loginController.text.isNotEmpty) {
      var response = await http.post(
        Uri.parse("https://ilatouba.with6.dolicloud.com/api/index.php/login"),
        body: {
          'login': loginController.text,
          'password': passwordController.text,
        },
      );
      if (response.statusCode == 200) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Données invalides"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Les champs doivent pas être vides"),
        ),
      );
    }
  }
}
