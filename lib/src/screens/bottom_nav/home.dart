import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/core/utils/page_name.dart';
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
      PageName(name: AppLocalizations.of(context).home),
    ]);
  }
}
