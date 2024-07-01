import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<dynamic> loadJsonData() async {
  String jsonString = await rootBundle.loadString('assets/data.json');
  var data = jsonDecode(jsonString);
  return data;
}

class ChatItem extends StatefulWidget {
  const ChatItem({Key? key}) : super(key: key);
  // final String menuItem;
  @override
  _MyChatItemState createState() => _MyChatItemState();
}

class _MyChatItemState extends State<ChatItem> {
  late dynamic listing;
  late var jsonData;
  late Future<dynamic> _jsonData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadJsonData(),
      builder: (context, snapshot) {
        List<Widget> ChatItem = [];
        List<dynamic> navBarItem = [];
        if (snapshot.hasData) {
          dynamic jsonData = snapshot.data;
          print(jsonData);
          navBarItem = jsonData['dms'];
          navBarItem.forEach((menu) {
            var dropdownVal;
            ChatItem.add(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(6.0),
                    color: Color.fromARGB(100, 249, 237, 255),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      iconColor: Colors.white70,
                      hintText: 'Find a DM',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
            );
            menu['items'].forEach((item) {
              item['icon'] != null
                  ? ChatItem.add(Row(
                      children: [
                        Container(
                          height: 22,
                          width: 23,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: item['name'].contains('Add')
                                  ? const Color.fromARGB(255, 67, 3, 80)
                                  : Color.fromARGB(255, 156, 250, 195),
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(
                            color: Color.fromARGB(255, 249, 248, 250),
                            IconData(int.parse(item['icon']),
                                fontFamily: 'MaterialIcons'),
                          ),
                        ),
                        item['description'] != null
                            ? Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      // textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      child: Text(
                                        softWrap: true,
                                        item['description'],
                                        // textDirection: TextDirection.ltr,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Text(
                                item['name'],
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                      ],
                    ))
                  : ChatItem.add(Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        item['name'],
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ));
              // item['description'] != null
              //     ? ChatItem.add(Text(item['description']))
              //     : ChatItem.add(Container());
            });
          });

          return SizedBox(
            // width: 200,
            child: Column(
              children: ChatItem,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // textDirection: TextDirection.ltr,
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
