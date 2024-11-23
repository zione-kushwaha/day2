import 'package:flutter/material.dart';
import 'animation0.dart';
import 'animation1.dart';
import 'animation2.dart';

class ScaffoldPart extends StatefulWidget {
  const ScaffoldPart({super.key});

  @override
  State<ScaffoldPart> createState() => _ScaffoldPartState();
}

class _ScaffoldPartState extends State<ScaffoldPart> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Animation day 2'),
        centerTitle: true,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.animation_outlined),
            label: 'Animation 1',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.animation_outlined)),
            label: 'Animation 2',
          ),
          NavigationDestination(
            icon: Badge(
              child: Icon(Icons.animation),
            ),
            label: 'Animation 3',
          ),
        ],
      ),
      body: <Widget>[
        const animation2(),
        const animation1(),
        RotatingRectangle(),
      ][currentPageIndex],
    );
  }
}
