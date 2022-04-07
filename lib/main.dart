import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

// ListView.builder(
//         itemCount: 10,
//         itemBuilder: (context, index) => Text("Helli $index"),
//       ),
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String url = "https://api.github.com/users/hammadkahn";
  String? nameFromAPI;
  String? bioFromAPI;
  bool loading = false;

  CallApi() async {
    var uri = Uri.parse(url);
    setState(() {
      loading = true;
      bioFromAPI = null;
      nameFromAPI = null;
    });
    try {
      var response = await http.get(uri);
      var responseString = response.body;
      Map<String, dynamic> parsedJson = jsonDecode(responseString);
      setState(() {
        nameFromAPI = parsedJson['name'];
        bioFromAPI = parsedJson['bio'];
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "API CALLING",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("NAME FROM GITHUB:"),
            if (nameFromAPI != null) Text(nameFromAPI!),
            if (loading) CircularProgressIndicator(),
            Text("BIO FROM GITHUB:"),
            if (bioFromAPI != null) Text(bioFromAPI!),
            if (loading) CircularProgressIndicator(),
            ElevatedButton(onPressed: CallApi, child: Text("DABAOOOOO"))
          ]),
        ));
  }
}
