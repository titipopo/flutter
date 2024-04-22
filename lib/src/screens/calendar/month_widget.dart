import 'package:chatapp/src/models/day.dart';
import 'package:chatapp/core/utils/datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const List<String> _shortWeekdays = <String>[
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat'
];

const List<String> _months = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

class MonthWidget extends StatefulWidget {
  const MonthWidget({super.key, required this.now, required this.notifyParent});

  final DateTime now;
  final Function(dynamic newDate) notifyParent;

  @override
  State<MonthWidget> createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget> {
  List<DayModel> getDaysInMonth(BuildContext context) {
    DateTime firstDayOfMonth =
        DateTime.utc(widget.now.year, widget.now.month, 1);

    List<DayModel> days = <DayModel>[];
    int startDayIndex = firstDayOfMonth.weekday == DateTime.saturday
        ? 6
        : firstDayOfMonth.weekday;

    for (int i = 0; i < startDayIndex; i++) {
      days.add(DayModel(day: '', disabled: true, amlich: ''));
    }

    int? prvLunarMonth;
    for (int i = 1;
        i <= DateUtils.getDaysInMonth(widget.now.year, widget.now.month);
        i++) {
      final lunar =
          convertSolar2Lunar(i, widget.now.month, widget.now.year, 7.0);
      String amlich;
      if (i == 1 || prvLunarMonth != lunar[1]) {
        amlich = '${lunar[0]}/${lunar[1]}';
        prvLunarMonth = lunar[1];
      } else {
        amlich = '${lunar[0]}';
      }
      Color color;
      switch (days.length % 7) {
        case 6:
          color = Theme.of(context).colorScheme.tertiary;
          break;
        case 0:
          color = Theme.of(context).colorScheme.surfaceTint;
          break;
        default:
          color = Theme.of(context).colorScheme.surface;
          break;
      }

      Color bgColor = Colors.transparent;
      if (widget.now.year == DateTime.now().year &&
          widget.now.month == DateTime.now().month &&
          i == DateTime.now().day) {
        bgColor = Theme.of(context).colorScheme.secondary;
      }

      Border border = Border.all(width: 0.0);
      if (i == widget.now.day) {
        border = Border.all(
            width: 2.0, color: Theme.of(context).colorScheme.outline);
      }
      days.add(DayModel(
          day: i < 10 ? '$i' : '$i',
          disabled: false,
          amlich: amlich,
          color: color,
          bgColor: bgColor,
          border: border));
    }

    int totalDays = (days.length / 7).ceil() * 7;
    int remainingDays = totalDays - days.length;

    for (int i = 0; i < remainingDays; i++) {
      days.add(DayModel(
        day: '',
        disabled: true,
        amlich: '',
      ));
    }

    final sixWeek = days.length;
    if (sixWeek < 42) {
      for (int i = 0; i < 42 - sixWeek; i++) {
        days.add(DayModel(
          day: '',
          disabled: true,
          amlich: '',
        ));
      }
    }

    return days;
  }

  refresh(String day) {
    if (day != "") {
      DateTime newDate =
          DateTime(widget.now.year, widget.now.month, int.parse(day));
      widget.notifyParent(newDate);
    }
  }

  nextMonth() {
    DateTime newDate =
        DateTime(widget.now.year, widget.now.month + 1, widget.now.day);
    widget.notifyParent(newDate);
  }

  priviousMonth() {
    DateTime newDate =
        DateTime(widget.now.year, widget.now.month - 1, widget.now.day);
    widget.notifyParent(newDate);
  }

  @override
  Widget build(BuildContext context) {
    List<DayModel> days = getDaysInMonth(context);
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  GestureDetector(
                    onTap: () => priviousMonth(),
                    child: const Icon(Icons.navigate_before),
                  ),
                  Text('${_months[widget.now.month - 1]} ${widget.now.year}',
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.fontSize,
                          fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () => nextMonth(),
                    child: const Icon(Icons.navigate_next),
                  ),
                ])),
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: List.generate(_shortWeekdays.length, (index) {
              return Text(_shortWeekdays[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ));
            })),
        Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                children: List<Widget>.generate(6, (weekIndex) {
                  List<DayModel> week = days.sublist(
                      weekIndex * DateTime.daysPerWeek,
                      (weekIndex * DateTime.daysPerWeek) +
                          DateTime.daysPerWeek);

                  return Expanded(
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textBaseline: TextBaseline.alphabetic,
                          children: List<Widget>.generate(DateTime.daysPerWeek,
                              (index) {
                            return Expanded(
                                child: FittedBox(
                                    child: GestureDetector(
                                        onTap: () => refresh(week[index].day),
                                        child: Container(
                                            padding: const EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                                color: week[index].bgColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5.0)),
                                                border: week[index].border),
                                            child: Column(children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(week[index].day,
                                                      style: TextStyle(
                                                        color:
                                                            week[index].color,
                                                      ))
                                                ],
                                              ),
                                              Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(week[index].amlich,
                                                        style: TextStyle(
                                                          fontSize:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelSmall
                                                                  ?.fontSize,
                                                          color:
                                                              week[index].color,
                                                        ))
                                                  ]),
                                            ])))));
                          })));
                }))),
      ],
    );
  }
}
