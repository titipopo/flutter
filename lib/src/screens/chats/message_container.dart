import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer(
      {super.key,
      required this.child,
      required this.mediaWidth,
      required this.isSender});

  final Widget child;
  final double mediaWidth;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          debugPrint('tapped');
        },
        child: Container(
           margin: const EdgeInsets.only(
                left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
            padding:isSender?
                const EdgeInsets.only(left: 10.0, top: 5.0, right: 15.0, bottom: 15.0):
                const EdgeInsets.only(left: 15.0, top: 5.0, right: 10.0, bottom: 15.0),
            constraints: BoxConstraints(
              maxWidth: mediaWidth * 0.6,
            ),
            decoration: BoxDecoration(
              color: isSender
                  ? Theme.of(context).colorScheme.surfaceTint
                  : Theme.of(context).colorScheme.scrim,
            ),
            child: child));
  }
}
