import 'package:chatapp/src/screens/musics/songs_list.dart';
import 'package:flutter/material.dart';

class AllSongScreen extends StatefulWidget {
  const AllSongScreen({super.key});

  @override
  State<AllSongScreen> createState() => _AllSongScreenState();
}

class _AllSongScreenState extends State<AllSongScreen> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: _loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : const SongsList(),
    );
  }

  @override
  void initState() {
    super.initState();
    simulate();
  }

  simulate() async {
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _loading = false;
    });
  }
}
