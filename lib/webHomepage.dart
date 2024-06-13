import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_3/listItems.dart';

class Webhomepage extends StatefulWidget {
  const Webhomepage({super.key, required this.title});
  final String title;

  @override
  State<Webhomepage> createState() => _WebhomepageState();
}

class _WebhomepageState extends State<Webhomepage> {
  var _currentIndex = 0;

  late OverlayEntry _overlayEntry;

  void _showPopup(Widget content, Offset offset) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
          top: offset.dy,
          left: offset.dx,
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
                padding: const EdgeInsets.all(10.0),
                color: const Color.fromARGB(255, 67, 3, 80),
                child: Column(
                  children: [
                    FloatingActionButton(
                      mini: true,
                      backgroundColor: const Color.fromARGB(255, 242, 222, 246),
                      onPressed: () {},
                      child: const Icon(
                        IconData(
                          77,
                        ),
                        size: 25,
                        color: Color.fromARGB(255, 14, 0, 16),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                      icon: Icon(
                        _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                      ),
                      color: Colors.white,
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
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _currentIndex = 1;
                          });
                        },
                        icon: Icon(
                          _currentIndex == 1
                              ? Icons.chat_bubble_rounded
                              : Icons.chat_bubble_outline_rounded,
                        ),
                        color: Colors.white,
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
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _currentIndex = 2;
                          });
                        },
                        icon: Icon(
                          _currentIndex == 2
                              ? Icons.notifications
                              : Icons.notifications_outlined,
                        ),
                        color: Colors.white,
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
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _currentIndex = 3;
                          });
                        },
                        icon: const Icon(Icons.more_horiz),
                        color: Colors.white,
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
                color: const Color.fromARGB(255, 67, 3, 80),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(10.0)),
                    color: Color.fromARGB(255, 112, 1, 134),
                    // color: Colors.transparent,
                  ),
                  child: Center(
                      child: Column(children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'MI2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
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
                          ],
                        ),
                        const SizedBox(width: 40.0),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.filter_list_rounded,
                            color: Colors.white70,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.post_add,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ])),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
