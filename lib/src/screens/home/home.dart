import 'package:chatapp/src/screens/home/calendar.dart';
import 'package:chatapp/src/screens/home/day_widget.dart';
import 'package:chatapp/src/utils/page_name.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _now = DateTime.now();

  refresh(dynamic newDate) {
    setState(() {
      _now = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const PageName(name: 'Home'),
      Expanded(child: DayWidget(now: _now)),
      Expanded(child: CalendarWidget(now: _now, notifyParent: refresh)),
    ]);
  }
}
