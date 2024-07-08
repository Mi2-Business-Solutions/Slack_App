import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/loginPage.dart';
import 'package:flutter_application_3/mobilePageItems/activityPage.dart';
import 'package:flutter_application_3/mobilePageItems/dMsPage.dart';
import 'package:flutter_application_3/mobilePageItems/homePage.dart';

void main() {
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Slack',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(onPrimary: Colors.white),
          useMaterial3: true,
        ),
        home: const Loginpage(logo: 'assets/mi2_logo.webp'));
  }
}

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key, required this.title});
  final String title;

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  final List<String> navBarItemNames = ['Home', 'DMs', 'Activity'];
  String _title = 'MI2';
  var _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> navBarItems = [
      BottomNavigationBarItem(
        icon: Icon(
          _currentIndex == 0 ? Icons.home : Icons.home_outlined,
          color: _currentIndex == 0 ? Colors.black : null,
        ),
        label: navBarItemNames[0],
      ),
      BottomNavigationBarItem(
        icon: Icon(
          _currentIndex == 1
              ? Icons.chat_bubble_rounded
              : Icons.chat_bubble_outline_rounded,
          color: _currentIndex == 1 ? Colors.black : null,
        ),
        label: navBarItemNames[1],
      ),
      BottomNavigationBarItem(
        icon: Icon(
            _currentIndex == 2
                ? Icons.notifications
                : Icons.notifications_outlined,
            color: _currentIndex == 2 ? Colors.black : null),
        label: navBarItemNames[2],
      ),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: navBarItems,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
            if (navBarItemNames[index] == 'Home') {
              _title = 'MI2';
            } else if (navBarItemNames[index] == 'DMs') {
              _title = 'Direct Messages';
            } else {
              _title = navBarItemNames[index];
            }
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 53, 3, 63),
        leading: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              mini: true,
              backgroundColor: const Color.fromARGB(255, 242, 222, 246),
              onPressed: () {
                Scaffold.of(context)
                    .openDrawer(); // Open drawer on menu icon click
              },
              child: const Icon(
                IconData(
                  77,
                ),
                size: 25,
                color: Color.fromARGB(255, 14, 0, 16),
              ),
            );
          },
        ),
        title: Text(
          _title,
          style: const TextStyle(
              color: Color.fromARGB(255, 242, 222, 246),
              fontWeight: FontWeight.bold),
        ),
        actions: [
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
      drawer: Drawer(
        width: MediaQuery.of(context).size.width - 50,
        child: Column(
          children: [
            Container(
              // padding: EdgeInsets.only(left: 10, right: 5),
              margin: EdgeInsets.fromLTRB(5, 20, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: const Text(
                      'Workspaces',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  // DrawerHeader(
                  //   padding: EdgeInsets.only(left: 10, right: 5),
                  //   margin: EdgeInsets.zero,
                  //   decoration: BoxDecoration(
                  //       border:
                  //           Border(bottom: BorderSide(color: Colors.transparent))),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Text(
                  //         'Workspaces',
                  //         style: TextStyle(
                  //             color: Colors.black,
                  //             fontSize: 24,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.black, width: 4),
                        ),
                        child: Container(
                            width: 45,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 203, 205, 205),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                'M',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MI2",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('mi2bizsolutions.slack.com')
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.more_vert)
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            const Divider(
              thickness: 1,
              color: Color.fromARGB(255, 203, 205, 205),
            ),
            ListTile(
              leading: Icon(
                Icons.add,
                size: 30,
              ),
              title: const Text('Add a workspace'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined),
              title: const Text('Preferences'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 53, 3, 63)),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          iconColor: Colors.white70,
                          hintText: 'Jump to or search...',
                          hintStyle: TextStyle(color: Colors.white70),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white70,
                          ),
                          suffixIcon: Icon(
                            Icons.mic,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(6.0),
                    color: const Color.fromARGB(255, 111, 3, 132),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.filter_list_rounded,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                MobileViewHomeWidget(),
                DmsPageWidget(),
                ActivityPageWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
