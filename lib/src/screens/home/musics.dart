import 'package:flutter/material.dart';

class MusicsScreen extends StatefulWidget {
  const MusicsScreen({super.key});

  @override
  State<MusicsScreen> createState() => _MusicsScreenState();
}

class _MusicsScreenState extends State<MusicsScreen> {

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Musics'));
  }
}
