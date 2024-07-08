import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/mobilePageItems/newPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

// Function to load JSON data
Future<dynamic> loadJsonData() async {
  try {
    String jsonString = await rootBundle.loadString('assets/data.json');
    var data = jsonDecode(jsonString);
    return data;
  } catch (e) {
    print('Error loading JSON file: $e');
    return null;
  }
}

class ImageItem {
  final String imageAssetPath;
  final String description;

  ImageItem(this.imageAssetPath, this.description);
}

final List<ImageItem> images = [
  ImageItem('assets/animal_img.png', "You've caught up with everything."),
  ImageItem('assets/congrats_img.png', "You're up to date."),
  ImageItem('assets/horse_img.png', "Here's a pony."),
  ImageItem('assets/hands_img.png', "Isn't it nice?"),
  ImageItem('assets/sunny_img.png', "You've read it all."),
];

class ActivityPageWidget extends StatefulWidget {
  const ActivityPageWidget({super.key});

  @override
  _ActivityPageWidgetState createState() => _ActivityPageWidgetState();
}

class _ActivityPageWidgetState extends State<ActivityPageWidget> {
  late Future<dynamic> _jsonData;
  int selectedIndex = 0;
  bool unreadMessages = false;
  final random = Random();

  @override
  void initState() {
    super.initState();
    _jsonData = loadJsonData();
  }

  void _toggleUnreadMessages() {
    setState(() {
      unreadMessages = !unreadMessages;
    });
  }

  void _selectOption(int index) {
    setState(() {
      selectedIndex = index;
      unreadMessages =
          false; // Reset unread messages when selecting a new option
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _jsonData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dynamic jsonData = snapshot.data;
            List<dynamic> options = jsonData['activityOptions'] ?? [];
            List<dynamic> activities = jsonData['activityList'] ?? [];
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(options.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ChoiceChip(
                            selectedColor: Color.fromARGB(255, 111, 3, 132),
                            showCheckmark: false,
                            avatar: options[index]['icon'] != null
                                ? Icon(
                                    getIconData(options[index]['icon']),
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                  )
                                : null,
                            label: Text(
                              options[index]['name'],
                              style: TextStyle(
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            selected: selectedIndex == index,
                            onSelected: (bool selected) {
                              _selectOption(index);
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                activityBodyWidget(options[selectedIndex], activities, options),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: UnreadMessagesButton(
        unreadMessages: unreadMessages,
        onPressed: _toggleUnreadMessages,
      ),
    );
  }

  IconData getIconData(String? iconName) {
    switch (iconName) {
      case 'at':
        return FontAwesomeIcons.at;
      case 'signalMessenger':
        return FontAwesomeIcons.solidMessage;
      case 'faceSmile':
        return FontAwesomeIcons.solidFaceSmile;
      case 'appStore':
        return FontAwesomeIcons.appStore;
      case 'paperPlane':
        return FontAwesomeIcons.paperPlane;
      default:
        return Icons.help;
    }
  }

  Widget activityBodyWidget(option, activities, options) {
    if (unreadMessages) {
      var index = random.nextInt(images.length);
      ImageItem imageItem = images[index];
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imageItem.imageAssetPath, width: 50, height: 50),
              Text(
                getUnreadMessageText(option),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                imageItem.description,
                style: TextStyle(color: const Color.fromARGB(255, 74, 74, 74)),
              ),
            ],
          ),
        ),
      );
    }

    List<dynamic> filteredActivities = option['name'] == "All"
        ? activities
        : activities
            .where((activity) => activity['type'] == option['name'])
            .toList();

    return Expanded(
      child: filteredActivities.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/at_the_rate.jpeg',
                    width: 150,
                    height: 100,
                  ),
                  getTitleForEmptyList(option),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      "You'll start to see activity if you join some conversations.",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewPage()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Color.fromARGB(255, 2, 82, 50),
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the radius as needed
                          ),
                        ),
                      ),
                      child: Text(
                        'Browse channels',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )
          : ListView.builder(
              itemCount: filteredActivities.length,
              itemBuilder: (context, index) {
                var item =
                    filteredActivities[index]; // Directly access item here
                var currentOption = option['name'] == "All"
                    ? options.firstWhere((opt) => opt['name'] == item['type'])
                    : option;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (currentOption['icon'] != null)
                                Icon(
                                  getIconData(currentOption['icon']),
                                  color: Colors.black,
                                  size: 15,
                                ),
                              SizedBox(width: 5.0),
                              Text(
                                '${currentOption['name']} in ${item['group']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            item['date'] ?? '',
                            style: TextStyle(
                              color: Color.fromARGB(255, 62, 62, 62),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: item['icon'] != null
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 233, 242, 249),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(
                                size: 50,
                                color: Color.fromARGB(255, 3, 156, 118),
                                IconData(
                                  int.parse(item['icon']),
                                  fontFamily: 'MaterialIcons',
                                ),
                              ),
                            )
                          : null,
                      title: Text(item['name'] ?? ''),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item['description'].toString().contains('Hello'))
                            Icon(
                              Icons.waving_hand,
                              color: Color.fromARGB(255, 253, 201, 46),
                            ),
                          Expanded(
                            child: Text(
                              softWrap: true,
                              item['description'] ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  String getUnreadMessageText(option) {
    switch (option['name']) {
      case 'All':
        return 'No unread messages yet';
      case 'Mentions':
        return 'No unread mentions yet';
      case 'Threads':
        return 'No unread threads yet';
      case 'Reactions':
        return 'No unread reactions yet';
      case 'Apps':
        return 'No unread app notifications yet';
      case 'Invitations':
        return 'No unread invitations yet';
      default:
        return 'No unread messages yet';
    }
  }

  Widget getTitleForEmptyList(option) {
    switch (option['name']) {
      case 'All':
        return Text(
          'No conversations yet',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        );
      case 'Mentions':
        return Text(
          'No mentions yet',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        );
      case 'Threads':
        return Text(
          'No threads yet',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        );
      case 'Reactions':
        return Text(
          'No reactions yet',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        );
      case 'Apps':
        return Text(
          'No app notifications yet',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        );
      case 'Invitations':
        return Text(
          'No invitations yet',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        );
      default:
        return const Gap(0);
    }
  }
}

class UnreadMessagesButton extends StatelessWidget {
  final bool unreadMessages;
  final VoidCallback onPressed;

  UnreadMessagesButton({required this.unreadMessages, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: unreadMessages
              ? Color.fromARGB(255, 111, 3, 132)
              : Color.fromARGB(31, 85, 84, 84),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 2), // Changes position of shadow
            ),
          ],
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Unread messages",
                  style: TextStyle(
                    color: unreadMessages ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: unreadMessages ? 8.0 : 0.0),
                if (unreadMessages)
                  Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
