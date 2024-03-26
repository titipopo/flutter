import 'package:chatapp/src/screens/orthers/all_song_screen.dart';
import 'package:chatapp/src/screens/orthers/favourite_screen.dart';
import 'package:chatapp/src/screens/orthers/now_playing.dart';
import 'package:chatapp/src/screens/orthers/playlist_screen.dart';
import 'package:chatapp/src/utils/page_name.dart';
import 'package:flutter/material.dart';

class MusicsScreen extends StatefulWidget {
  const MusicsScreen({super.key});

  @override
  State<MusicsScreen> createState() => _MusicsScreenState();
}

class _MusicsScreenState extends State<MusicsScreen> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Column(children: [
        PageName(name: 'Musics'),
        TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.audiotrack,
                size: 25,
              ),
              text: 'Songs',
              iconMargin: EdgeInsets.only(top: 10),
            ),
            Tab(
              icon: Icon(
                Icons.favorite,
                size: 25,
              ),
              text: 'Favorites',
              iconMargin: EdgeInsets.only(top: 10),
            ),
            Tab(
              icon: Icon(
                Icons.queue_music,
                size: 25,
              ),
              text: 'Playlists',
              iconMargin: EdgeInsets.only(top: 10),
            ),
          ],
        ),
        Expanded(
            child: Stack(
          children: [
            TabBarView(
              children: [
                AllSongScreen(),
                FavouriteScreen(),
                PlaylistScreen(),
              ],
            ),
            NowPlaying(),
          ],
        )),
      ]),
    );
  }
}
