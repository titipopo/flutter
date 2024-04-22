import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/src/screens/musics/all_song_screen.dart';
import 'package:chatapp/src/screens/musics/favourite_screen.dart';
import 'package:chatapp/src/screens/musics/now_playing_short_screen.dart';
import 'package:chatapp/src/screens/musics/playlist_screen.dart';
import 'package:chatapp/core/utils/page_name.dart';
import 'package:flutter/material.dart';

class MusicsScreen extends StatefulWidget {
  const MusicsScreen({super.key});

  @override
  State<MusicsScreen> createState() => _MusicsScreenState();
}

class _MusicsScreenState extends State<MusicsScreen> {
  int activeTabIndex = 1;
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Column(children: [
       PageName(name: AppLocalizations.of(context).musics),
        TabBar(
          onTap:  (index) {
        setState(() {
          activeTabIndex = index;
        });
      },
          tabs: const [
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
        const Expanded(
            child: Stack(
          children: [
            TabBarView(
              children: [
                AllSongScreen(),
                FavouriteScreen(),
                PlaylistScreen(),
              ],
            ),
            NowPlayingShortScreen(),
          ],
        )),
      ]),
    );
  }
}
