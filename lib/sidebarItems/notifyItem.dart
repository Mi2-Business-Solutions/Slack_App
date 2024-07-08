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

class NotifyItem extends StatefulWidget {
  const NotifyItem({Key? key}) : super(key: key);

  @override
  _NotifyItemState createState() => _NotifyItemState();
}

class _NotifyItemState extends State<NotifyItem> {
  late List<dynamic> activities = [];

  @override
  void initState() {
    super.initState();
    loadActivities();
  }

  Future<void> loadActivities() async {
    var jsonData = await loadJsonData();
    setState(() {
      activities = jsonData['activity'][0]['items'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        var item = activities[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: item['name'].contains('Add')
                      ? const Color.fromARGB(255, 67, 3, 80)
                      : const Color.fromARGB(255, 156, 250, 195),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  IconData(int.parse(item['icon']),
                      fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                  size: 40,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.waving_hand,
                          size: 20,
                          color: Colors.amber[400],
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            item['description'],
                            style: TextStyle(color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
