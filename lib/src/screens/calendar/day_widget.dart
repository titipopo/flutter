import 'package:chatapp/core/utils/datetime.dart';
import 'package:flutter/material.dart';

class DayWidget extends StatefulWidget {
  const DayWidget({super.key, required this.now});

  final DateTime now;

  @override
  State<DayWidget> createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {
  @override
  Widget build(BuildContext context) {
    final lunar = convertSolar2Lunar(
        widget.now.day, widget.now.month, widget.now.year, 7.0);
    final jd = jdFromDate(widget.now.day, widget.now.month, widget.now.year);
    final lunarDay = lunar[0];
    final lunarMonth = lunar[1];
    final lunarYear = lunar[2];
    final isLeap = lunar[3];
    final dayOfW = getDayOfWeek(jd);
    final monthName = getMonthName(lunarMonth, 30, isLeap);
    final yearCanChi = getYearCanChi(lunarYear);
    final monthCanChi = getMonthCanChi(lunarMonth, lunarYear);
    final dayCanChi = getDayCanChi(jd);
    final hourCanChi = getHourCanChi(jd);
    final tietKhi = getTietKhi(jd);
    final dayEvent = getDayInfo(lunarDay, lunarMonth);
    final gioHoangDao = getGioHoangDao(jd);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
            'Tháng ${'0${widget.now.month}'.substring('0${widget.now.month}'.length - 2)} Năm ${widget.now.year}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
            )),
        Text('${widget.now.day}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.displayMedium?.fontSize,
            )),
        Text(dayOfW,
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(monthName),
              Text('$lunarDay',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                  )),
              Text(yearCanChi),
            ]),
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(monthCanChi),
              Text(dayCanChi),
              Text(hourCanChi),
              Text(tietKhi),
            ]),
          ],
        ),
        Text(
          dayEvent,
          style: TextStyle(color: Theme.of(context).colorScheme.surfaceTint),
        ),
        Container(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  gioHoangDao,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ))),
      ],
    );
  }
}
