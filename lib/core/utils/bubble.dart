import 'dart:async';

import 'package:chatapp/core/utils/bubble_container.dart';
import 'package:flutter/material.dart';

class Bubble extends StatefulWidget {
  const Bubble({super.key, required this.child});

  final Widget child;
  @override
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  Offset _position = const Offset(0, 0);
  Timer? _timer;
  double _opacity = 1;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      timer.cancel();
      setState(() {
        _opacity = 0.5;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: Draggable(
          feedback: BubbleContainer(
            child: widget.child,
          ),
          childWhenDragging: Opacity(
            opacity: 0,
            child: BubbleContainer(
              child: widget.child,
            ),
          ),
          onDragStarted: () => setState(() {
                _opacity = 1;
              }),
          onDragEnd: (details) {
            final width = MediaQuery.of(context).size.width;
            final height = MediaQuery.of(context).size.height;
            final bottomPadding = const NavigationBarThemeData().height ?? 100;
            Offset off = Offset(details.offset.dx, details.offset.dy);
            if (off.dx < 50) {
              off = Offset(0, off.dy);
            } else if (off.dx > width - 50) {
              off = Offset(width - 50, off.dy);
            }
            if (off.dy < 50) {
              off = Offset(off.dx, 0);
            } else if (off.dy > height - bottomPadding) {
              off = Offset(off.dx, height - bottomPadding - 50);
            }
            setState(() => _position = off);
            _startTimer();
          },
          child: Opacity(
            opacity: _opacity,
            child: BubbleContainer(
              child: widget.child,
            ),
          )),
    );
  }
}
