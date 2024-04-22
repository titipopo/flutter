import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/src/screens/calendar/month_widget.dart';
import 'package:chatapp/src/screens/calendar/day_widget.dart';
import 'package:chatapp/core/utils/page_name.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _now = DateTime.now();

  refresh(dynamic newDate) {
    setState(() {
      _now = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      PageName(name: AppLocalizations.of(context).calendar),
      Expanded(child: DayWidget(now: _now)),
      Expanded(child: MonthWidget(now: _now, notifyParent: refresh)),
    ]);
  }
}
