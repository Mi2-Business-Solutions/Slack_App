import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_3/listItems.dart';
import 'package:flutter_application_3/sidebarItems/chatItem.dart';
import 'package:flutter_application_3/sidebarItems/homeItem.dart';
import 'package:flutter_application_3/sidebarItems/notifyItem.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'web_title_stub.dart' if (dart.library.html) 'web_title_helper_web.dart';

Future<dynamic> loadJsonData() async {
  String jsonString = await rootBundle.loadString('assets/data.json');
  var data = jsonDecode(jsonString);
  return data;
}

class Webhomepage extends StatefulWidget {
  const Webhomepage({super.key, required this.title});
  final String title;

  @override
  State<Webhomepage> createState() => _WebhomepageState();
}

class _WebhomepageState extends State<Webhomepage> {
  var _currentIndex = 0;
  bool _showHomeItem = true;
  bool _showChatContent = false;
  bool _showNotifications = false;
  bool _showMoreContent = false;
  bool _toggleStatus = false;
  late OverlayEntry _overlayEntry;

  void _showPopup(Widget content, Offset offset) {
    final screenWidth = MediaQuery.of(context).size.width;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
          top: offset.dy,
          left: screenWidth > 900 ? offset.dx : offset.dx - 350.0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: content,
          )),
    );
    Overlay.of(context).insert(_overlayEntry);
  }

  void _hidePopup() {
    _overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      setDocumentTitle('MI2');
    });

    final screenWidth = MediaQuery.of(context).size.width;
    var dropdownVal;
    return Scaffold(
      body: Column(children: [
        Container(
          height: 40.0,
          color: const Color.fromARGB(255, 67, 3, 80),
          child: Row(
            children: [
              const Spacer(
                flex: 3,
              ),
              const Expanded(
                // flex: 1,
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white70,
                  ),
                ),
              ),
              const Expanded(
                // flex: 1,
                child: Center(
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white70,
                  ),
                ),
              ),
              const Expanded(
                // flex: 1,
                child: Center(
                  child: Icon(
                    Icons.access_time_outlined,
                    color: Colors.white70,
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(6.0),
                      color: const Color.fromARGB(255, 111, 3, 132),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        iconColor: Colors.white70,
                        hintText: 'Search MI2',
                        hintStyle: TextStyle(color: Colors.white),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 4,
              ),
              const Expanded(
                // flex: 1,
                child: Center(
                  child: Icon(
                    Icons.help_outline,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                width:
                    screenWidth > 900 ? screenWidth * 0.05 : screenWidth * 0.09,
                padding: const EdgeInsets.all(10.0),
                color: const Color.fromARGB(255, 67, 3, 80),
                child: Column(
                  children: [
                    FloatingActionButton(
                      mini: true,
                      backgroundColor: const Color.fromARGB(255, 242, 222, 246),
                      onPressed: () {},
                      child: Icon(
                        IconData(
                          77,
                        ),
                        size: screenWidth > 900 ? 25 : 20,
                        color: Color.fromARGB(255, 14, 0, 16),
                      ),
                    ),
                    Column(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _currentIndex = 0;
                                  _showHomeItem = true; // Show HomeItem widget
                                  _showChatContent =
                                      false; // Hide other content
                                  _showNotifications = false;
                                  _showMoreContent = false;
                                });
                              },
                              icon: Icon(
                                _currentIndex == 0
                                    ? Icons.home
                                    : Icons.home_outlined,
                              ),
                              color: Colors.white,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                    MouseRegion(
                      onEnter: (event) {
                        _showPopup(
                          const SizedBox(
                            width: 200, // Set the width of the popup
                            child: ListItems(menuItem: 'chat'),
                          ),
                          event.position,
                        );
                      },
                      onExit: (event) {
                        _hidePopup();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _currentIndex = 1;
                                _showHomeItem = false; // Hide other content
                                _showChatContent =
                                    true; // Show ChatContent widget
                                _showNotifications = false;
                                _showMoreContent = false;
                              });
                            },
                            icon: Icon(
                              _currentIndex == 1
                                  ? Icons.chat_bubble_rounded
                                  : Icons.chat_bubble_outline_rounded,
                            ),
                            color: Colors.white,
                          ),
                          Text(
                            ' DMs',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    MouseRegion(
                      onEnter: (event) {
                        _showPopup(
                          const SizedBox(
                            width: 200, // Set the width of the popup
                            child: ListItems(
                              menuItem: 'notify',
                            ),
                          ),
                          event.position,
                        );
                      },
                      onExit: (event) {
                        _hidePopup();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _currentIndex = 2;
                                _showHomeItem = false; // Hide other content
                                _showChatContent = false;
                                _showNotifications =
                                    true; // Show NotificationsContent widget
                                _showMoreContent = false;
                              });
                            },
                            icon: Icon(
                              _currentIndex == 2
                                  ? Icons.notifications
                                  : Icons.notifications_outlined,
                            ),
                            color: Colors.white,
                          ),
                          Text(
                            'Activity',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    MouseRegion(
                      onEnter: (event) {
                        _showPopup(
                          const SizedBox(
                            width: 200, // Set the width of the popup
                            child: ListItems(
                              menuItem: 'more',
                            ),
                          ),
                          event.position,
                        );
                      },
                      onExit: (event) {
                        _hidePopup();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _currentIndex = 3;
                              });
                            },
                            icon: const Icon(Icons.more_horiz),
                            color: Colors.white,
                          ),
                          Text(
                            'More',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _currentIndex = 4;
                        });
                      },
                      icon: const Icon(Icons.add_circle),
                      color: Colors.white,
                    ),
                    IconButton(
                      iconSize: 40,
                      icon: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 242, 222, 246),
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Container(
                width:
                    screenWidth >= 900 ? screenWidth * 0.3 : screenWidth * 0.46,
                color: const Color.fromARGB(255, 67, 3, 80),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(10.0)),
                    color: Color.fromARGB(255, 112, 1, 134),
                    // color: Colors.transparent,
                  ),
                  child: Column(children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: _getHeading(),
                        ),
                        // const SizedBox(width: 40.0),
                        const Spacer(),
                        // FaIcon(FontAwesomeIcons.toggleOff),
                        Row(
                          children: [
                            const Text(
                              'Unread messages',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                            Switch.adaptive(
                              value: _toggleStatus,
                              onChanged: (bool value) {
                                setState(() {
                                  _toggleStatus = value;
                                });
                              },
                              activeColor: Colors.white,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.white30,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          iconSize: screenWidth > 900 ? 30 : 20,
                          icon: const Icon(
                            Icons.filter_list_rounded,
                            color: Colors.white70,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          iconSize: screenWidth > 900 ? 30 : 20,
                          icon: const Icon(
                            Icons.post_add,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    // const Expanded(child: HomeItem()),
                    Expanded(
                      child: _buildMainContent(),
                    )
                  ]),
                ),
              ),
              Expanded(
                flex: screenWidth > 600 ? 9 : 7,
                child: Text('Slack'),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget _getHeading() {
    switch (_currentIndex) {
      case 1:
        return const Text(
          'Direct Messages',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          overflow: TextOverflow.ellipsis, // Handle overflow
        );
      // return const Text(
      //   // textAlign: TextAlign.right,
      //   'Direct Messages',
      //   style: TextStyle(
      //       color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      // );
      case 2:
        return const Text(
          'Activity',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        );
      // case 3:
      //   return const Text(
      //     'More',
      //     style: TextStyle(
      //         color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      //   );
      default:
        return PopupMenuButton(
          position: PopupMenuPosition.under,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Text('Item 1'),
            ),
            const PopupMenuItem(
              value: 2,
              child: Text('Item 2'),
            ),
            const PopupMenuItem(
              value: 3,
              child: Text('Item 3'),
            ),
          ],
          child: const Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MI2',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              FaIcon(
                FontAwesomeIcons.angleDown,
                color: Colors.white,
                size: 15,
              ),
            ],
          ),
        );
    }
  }

  Widget _buildMainContent() {
    switch (_currentIndex) {
      case 0: // Home
        return const HomeItem();
      case 1: // DMs
        return const ChatItem();
      case 2: // Notifications
        return const NotifyItem();
      default:
        return const HomeItem();
    }
  }
}
