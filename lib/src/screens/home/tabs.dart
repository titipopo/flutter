import 'package:chatapp/src/screens/home/chat.dart';
import 'package:chatapp/src/screens/home/home.dart';
import 'package:chatapp/src/screens/home/musics.dart';
import 'package:chatapp/src/screens/home/profiles.dart';
import 'package:chatapp/src/screens/home/settings.dart';
import 'package:flutter/material.dart';

class TabList {
  static const List<Widget> tabs = [
     HomeScreen(),
     MusicsScreen(),
     ChatScreen(),
     SettingsScreen(),
     ProfileScreen(),
  ];
}
