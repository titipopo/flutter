import 'package:flutter/material.dart';

class VerticalSection extends StatelessWidget {
  const VerticalSection(
      {super.key, required this.label, required this.child, this.isInput});

  final String label;
  final Widget child;
  final bool? isInput;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.all(5.0),
              child: Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Theme.of(context).textTheme.labelLarge!.fontSize)))
        ],
      ),
      isInput == null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [child],
            )
          : child,
    ]);
  }
}
