import 'package:flutter/material.dart';
import 'package:flutter_application_3/loginPage.dart';

void main() {
  runApp(const MyApp());
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
        home: const Loginpage(logo: 'assets/slack-logo.png')
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> _navBarItems = [
      BottomNavigationBarItem(
        icon: Icon(
          _currentIndex == 0 ? Icons.home : Icons.home_outlined,
          color: _currentIndex == 0 ? Colors.black : null,
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          _currentIndex == 1
              ? Icons.chat_bubble_rounded
              : Icons.chat_bubble_outline_rounded,
          color: _currentIndex == 1 ? Colors.black : null,
        ),
        label: 'DMs',
      ),
      BottomNavigationBarItem(
        icon: Icon(
            _currentIndex == 2
                ? Icons.notifications
                : Icons.notifications_outlined,
            color: _currentIndex == 2 ? Colors.black : null),
        label: 'Activity',
      ),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _navBarItems,
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 53, 3, 63),
        leading: FloatingActionButton(
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
        title: Text(
          widget.title,
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
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(10.0),
                          // ),
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
        ],
      ),
    );
  }
}
