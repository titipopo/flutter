import 'package:flutter/material.dart';

class BubbleContainer extends StatelessWidget {
  const BubbleContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {debugPrint('tapped');},
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.secondary,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                  offset: const Offset(5, 5),
                  blurRadius: 3,
                )
              ],
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 2,
                style: BorderStyle.solid,
              )),
          child: child,
        ));
  }
}
