import "package:flutter/material.dart";

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({super.key, required this.child});

  final List<Widget> child;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(30.0))),
        child: Column(children: child));
  }
}
