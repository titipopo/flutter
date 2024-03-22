import 'package:chatapp/src/screens/home/calendar.dart';
import 'package:chatapp/src/screens/home/day_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateTime _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      DayWidget(now: _now),
      CalendarWidget(now: _now),
    ]));
  }
}
