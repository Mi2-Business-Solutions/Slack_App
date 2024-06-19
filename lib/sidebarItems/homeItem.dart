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

class HomeItem extends StatefulWidget {
  const HomeItem({Key? key}) : super(key: key);
  // final String menuItem;
  @override
  _MyHomeItemState createState() => _MyHomeItemState();
}

class _MyHomeItemState extends State<HomeItem> {
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
        List<Widget> HomeItem = [];
        List<dynamic> navBarItem = [];
        if (snapshot.hasData) {
          dynamic jsonData = snapshot.data;
          print(jsonData);
          // switch (widget.menuItem) {
          //   case 'chat':
          //     print('chat');
          //     navBarItem = jsonData['dms'];
          //     break;
          //   case 'notify':
          //     print('notify');
          //     navBarItem = jsonData['activity'];
          //     break;
          //   case 'more':
          //     print(jsonData['workspace']['name']);
          //     navBarItem = jsonData['more'];
          //     break;
          //   default:
          //     print('default');
          //     break;
          // }
          navBarItem = jsonData['homeItem'];
          navBarItem.forEach((menu) {
            var dropdownVal;
            HomeItem.add(Row(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: dropdownVal,
                    icon: const Icon(
                      // weight: 40,
                      size: 30,
                      Icons.arrow_drop_down_sharp,
                      color: Colors.white,
                    ),
                    onChanged: (value) {},
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text('1'),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text('2'),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text('3'),
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: Text('4'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    menu['name'],
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ],
            ));
            menu['items'].forEach((item) {
              item['icon'] != null
                  ? HomeItem.add(Row(
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
                        Text(
                          item['name'],
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ))
                  : HomeItem.add(Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        item['name'],
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ));
            });
          });

          return SizedBox(
            // width: 200,
            child: Column(
              children: HomeItem,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
