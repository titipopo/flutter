import 'package:flutter/material.dart';

class CustomCurvedNavigationBar extends StatelessWidget {
  const CustomCurvedNavigationBar({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            width: size.width,
            child: Stack(
              children: [
                CustomPaint(
                  painter: _CurvedPainter(theme.primaryColor),
                  size: Size(
                    size.width,
                    60,
                  ),
                ),
                Center(
                  heightFactor: .0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(180)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4),
                          blurRadius: 3,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: FloatingActionButton(
                      backgroundColor: const Color(0xff0D6EFD),
                      elevation: 2.0,
                      onPressed: () {},
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.music_note,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home),
                        color: theme.dividerColor,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.chat),
                        color: theme.dividerColor,
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: size.width * 0.20,
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        color: theme.dividerColor,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.account_circle),
                        color: theme.dividerColor,
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CurvedPainter extends CustomPainter {
  _CurvedPainter(this.color);
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, -30);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),radius: const Radius.elliptical(6, 4), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, -30);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, -30);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
