import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItems extends StatelessWidget {
  const ListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 70,
            color: const Color.fromARGB(255, 130, 255, 132),
            child: const Center(child: Text('A')),
          ),
          const Divider(
            thickness: 0.05,
          ),
          Container(
            height: 50,
            width: 70,
            color: Colors.amber[300],
            child: const Center(child: Text('B')),
          ),
          const Divider(),
          Container(
            height: 50,
            width: 70,
            color: Colors.amber[400],
            child: const Center(child: Text('C')),
          ),
          // const Divider(),
          // Container(
          //   height: 10,
          //   color: Colors.amber[500],
          //   child: const Center(child: Text('D')),
          // ),
        ],
      ),
    );
  }
}
