import 'package:chatapp/src/screens/home/tabs.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: TabList.tabs.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.audiotrack),
              label: 'Musics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        )
        //bottomNavigationBar: const CustomCurvedNavigationBar(),
        /*
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          CurvedNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          CurvedNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
           CurvedNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
           CurvedNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        //selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      */
        );
  }
}
