import 'package:flutter/material.dart';

class AuthScreenWidget extends StatelessWidget {
  const AuthScreenWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 370,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 70,
            right: 50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                  border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 2,
                      style: BorderStyle.solid)),
            ),
          ),
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                  border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 2,
                      style: BorderStyle.solid)),
            ),
          ),
          Positioned(
            top: 220,
            left: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                  border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 2,
                      style: BorderStyle.solid)),
            ),
          ),
          Positioned(
              top: 100,
              left: 0,
              width: 300,
              height: 100,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              )),
        ],
      ),
    );
  }
}
