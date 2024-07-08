import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/mobilePageItems/newPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Function to load JSON data
Future<dynamic> loadJsonData() async {
  String jsonString = await rootBundle.loadString('assets/data.json');
  var data = jsonDecode(jsonString);
  return data;
}

class DmsPageWidget extends StatefulWidget {
  const DmsPageWidget({super.key});

  @override
  _DmsPageWidgetState createState() => _DmsPageWidgetState();
}

// Define the State class
class _DmsPageWidgetState extends State<DmsPageWidget> {
  late Future<dynamic> _jsonData;
  final Color color1 = Color.fromARGB(255, 37, 233, 158);
  final Color color2 = Color.fromARGB(255, 207, 242, 232);
  int itemIndex = 0;
  @override
  void initState() {
    super.initState();
    _jsonData = loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _jsonData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dynamic jsonData = snapshot.data;
            List<dynamic> dms = jsonData['dms'] ?? [];
            // List<dynamic> dmsHistory = jsonData['dmsHistory'] ?? [];
            List<dynamic> dmsHistory = jsonData['dms'] ?? [];
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: 120,
                    child: _listOfUsers(dms),
                  ),
                  Divider(
                    color: const Color.fromARGB(255, 237, 232, 232),
                    height: 2,
                    thickness: 1,
                  ),
                  _listOfDMs(dmsHistory),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'herotag',
        backgroundColor: Color.fromARGB(255, 53, 3, 63),
        onPressed: () {
          // Implement message creation logic here
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPage()));
        },
        child: Icon(
          FontAwesomeIcons.penToSquare,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _listOfUsers(List<dynamic> dms) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: dms.expand<Widget>((dm) {
          return (dm['items'] as List<dynamic>).map<Widget>((item) {
            if (!item['name'].toString().contains('you')) {
              Color backgroundColor = (itemIndex % 2 == 0) ? color1 : color2;
              Color iconColor = (itemIndex % 2 == 0) ? color2 : color1;
              itemIndex++;

              return GestureDetector(
                onTap: () {
                  // navigate toconversation history
                },
                child: Container(
                  height: 120,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundColor,
                        ),
                        child: Icon(
                          getIconData(item['icon']),
                          size: 90,
                          color: iconColor,
                        ),
                      ),
                      Container(
                        width: 90,
                        child: Text(
                          item['name'],
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          }).toList();
        }).toList(),
      ),
    );
  }

  IconData getIconData(String iconName) {
    switch (iconName) {
      case '0xe491':
        return Icons.person;
      case '0xe047':
        return Icons.add;
      default:
        return Icons.help; // Default icon
    }
  }

  Widget _listOfDMs(List<dynamic> dms) {
    List<Widget> tiles = dms.expand<Widget>((dm) {
      return (dm['items'] as List<dynamic>).map<Widget>((item) {
        if (!item['name'].toString().contains('you')) {
          Color backgroundColor = (itemIndex % 2 == 0) ? color1 : color2;
          Color iconColor = (itemIndex % 2 == 0) ? color2 : color1;
          itemIndex++;

          return ListTile(
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: backgroundColor,
              ),
              padding: EdgeInsets.all(8.0),
              child: Icon(
                getIconData(item['icon']),
                size: 30,
                color: iconColor,
              ),
            ),
            title: Text(
              item['name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle:
                // item['description'] != null ? Text(item['description']) : null,
                item['name'].toString().contains('Aravind')
                    ? Text(
                        'You: Shaik Shabana Nasreen accepted your invitation to join Slack -- take a second to say hello.',
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )
                    : null,
            onTap: () {
              // Implement navigation to the conversation history screen
            },
          );
        }
        return Container();
      }).toList();
    }).toList();

    // Add the "Add new teammate" tile
    tiles.add(
      ListTile(
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(31, 12, 12, 12),
          ),
          child: Icon(
            FontAwesomeIcons.userPlus,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Add new teammate',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('Invite colleagues or external connections'),
        onTap: () {
          // Implement the add new teammate functionality
        },
      ),
    );

    return Column(
      children: tiles,
    );
  }
}
