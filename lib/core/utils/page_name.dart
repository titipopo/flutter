import 'package:flutter/material.dart';

class PageName extends StatelessWidget {
  const PageName({super.key, required this.name, this.child});

  final String name;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            border: Border.all(color: Theme.of(context).colorScheme.surfaceTint)),
        child: Row(children: [ 
          child ?? const SizedBox(),
          Text(name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                    Theme.of(context).textTheme.headlineMedium!.fontSize))]));
  }
}
