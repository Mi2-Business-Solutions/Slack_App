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

// Define the StatefulWidget class
class MobileViewHomeWidget extends StatefulWidget {
  const MobileViewHomeWidget({super.key});

  @override
  _MobileViewHomeWidgetState createState() => _MobileViewHomeWidgetState();
}

// Define the State class
class _MobileViewHomeWidgetState extends State<MobileViewHomeWidget> {
  late Future<dynamic> _jsonData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadJsonData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dynamic jsonData = snapshot.data;
            List<dynamic> homeItems = jsonData['homeItem'];
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: 120,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: _buildMainContent(),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: homeItems
                        .asMap()
                        .entries
                        .map((entry) =>
                            _buildExpansionPanel(entry.key, entry.value))
                        .toList(),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 190, 180, 180),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10)),
            height: 90,
            width: 100,
            padding: EdgeInsets.only(left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.chat_rounded),
                Text('Threads'),
                Text('Caught up')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 190, 180, 180),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10)),
            height: 90,
            width: 100,
            padding: EdgeInsets.only(left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(FontAwesomeIcons.solidBookmark),
                Text('Later'),
                Text('0 items')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 190, 180, 180),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10)),
            height: 90,
            width: 100,
            padding: EdgeInsets.only(left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.send),
                Text(
                  'Drafts & sent 0 drafts',
                  // style: TextStyle(overflow: TextOverflow.ellipsis),
                  softWrap: true,
                ),
                // Text('0 drafts')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 190, 180, 180),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10)),
            height: 90,
            width: 100,
            padding: EdgeInsets.only(left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(FontAwesomeIcons.headphones),
                Text('Huddles'),
                Text('0 live')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 190, 180, 180),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(25)),
            height: 50,
            width: 50,
            child: Icon(Icons.settings_outlined),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionPanel(int index, dynamic item) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        item['name'],
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: item['items']
          .map<Widget>((subItem) => ListTile(
              selectedColor: Color.fromARGB(255, 190, 180, 180),
              leading: subItem.containsKey('icon')
                  ? Icon(getIconData(subItem['icon']))
                  : null,
              title: Text(
                subItem['name'],
                style: TextStyle(
                    color: const Color.fromARGB(255, 78, 77, 77), fontSize: 19),
              )))
          .toList(),
    );
  }

  IconData getIconData(String iconName) {
    switch (iconName) {
      case '0xe047':
        return Icons.add;
      case '0xe491':
        return Icons.person;
      default:
        return Icons.help; // Default icon
    }
  }
}

// void main() {
//   runApp(MaterialApp(home: MobileViewHomeWidget()));
// }
