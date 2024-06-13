import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<dynamic> loadJsonData() async {
  String jsonString = await rootBundle.loadString('assets/data.json');
  var data = jsonDecode(jsonString);
  return data;
}

// final List<int> moreIcons = [0xf87b, 0xf0ed, 0xe269, 0xf8b5, 0xe18f];

class ListItems extends StatefulWidget {
  const ListItems({Key? key, required this.menuItem}) : super(key: key);
  final String menuItem;
  @override
  _MyListItemState createState() => _MyListItemState();
}

class _MyListItemState extends State<ListItems> {
  late dynamic listing;
  late var jsonData;
  late Future<dynamic> _jsonData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // switch (widget.menuItem) {
    //   case 'chat':
    //     print('chat');
    //     break;
    //   case 'notify':
    //     print('notify');
    //     break;
    //   case 'more':
    //     print(jsonData['workspace']['name']);
    //     // loadJsonData().then((data) {
    //     //   listing = data;
    //     //   print(listing);
    //     //   print('more');
    //     // });
    //     // listing = _jsonData;
    //     // print(listing);
    //     // print('more');
    //     break;
    //   default:
    //     print('default');
    //     break;
    // }
    return FutureBuilder(
      future: loadJsonData(),
      builder: (context, snapshot) {
        List<Widget> listItems = [];
        List<dynamic> navBarItem = [];
        if (snapshot.hasData) {
          dynamic jsonData = snapshot.data;
          print(jsonData);
          switch (widget.menuItem) {
            case 'chat':
              print('chat');
              navBarItem = jsonData['dms'];
              break;
            case 'notify':
              print('notify');
              navBarItem = jsonData['activity'];
              break;
            case 'more':
              print(jsonData['workspace']['name']);
              navBarItem = jsonData['more'];
              break;
            default:
              print('default');
              break;
          }
          navBarItem.forEach((menu) {
            listItems.add(
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(5),
                child: Text(menu['name'],
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16,
                        color: Color.fromARGB(255, 59, 59, 59))),
              ),
            );
            listItems.add(const Divider(
              thickness: 0.05,
            ));
            int itemCount = menu['items'].length;
            menu['items'].asMap().forEach((j, item) {
              listItems.add(
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 250, 248, 251),
                          borderRadius: BorderRadius.circular(5)),
                      child: item['icon'] != null
                          ? Icon(
                              color: const Color.fromARGB(255, 67, 3, 80),
                              IconData(int.parse(item['icon']),
                                  fontFamily: 'MaterialIcons'),
                            )
                          : Image.asset('assets/whale.png'),
                    ),
                    Expanded(
                      child: Column(
                        textDirection: TextDirection.ltr,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Text(item['name'],
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 59, 59, 59))),
                          ),
                          Container(
                              width: double.infinity,
                              child: item['description'] != null
                                  ? Text(item['description'],
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 10,
                                          color:
                                              Color.fromARGB(255, 59, 59, 59)))
                                  : null),
                        ],
                      ),
                    ),
                  ],
                ),
              );
              // listItems.add(const Divider(
              //   thickness: 0.05,
              // ));
              if (j != itemCount - 1) {
                listItems.add(const Divider(thickness: 0.05));
              }
            });
          });

          return SizedBox(
            // width: 200,
            child: Column(
              children: listItems,
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
