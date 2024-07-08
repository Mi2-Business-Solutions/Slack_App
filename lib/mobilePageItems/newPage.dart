import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Function to load JSON data
Future<dynamic> loadJsonData() async {
  String jsonString = await rootBundle.loadString('assets/data.json');
  var data = jsonDecode(jsonString);
  return data;
}

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  _NewPageState createState() => _NewPageState();
}

// Define the State class
class _NewPageState extends State<NewPage> {
  late Future<dynamic> _jsonData;
  @override
  void initState() {
    super.initState();
    _jsonData = loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Page'),
        backgroundColor: const Color.fromARGB(255, 37, 233, 158),
      ),
      body: Text('New Page'),
      floatingActionButton: FloatingActionButton(
        child: Text(
          "Unread messages X",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
