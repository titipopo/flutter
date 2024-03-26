import 'package:flutter/material.dart';

class PageName extends StatelessWidget {
  const PageName({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            border: Border.all(color: const Color(0xFFFF6347))),
        child: Text(name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                    Theme.of(context).textTheme.headlineMedium!.fontSize)));
  }
}
