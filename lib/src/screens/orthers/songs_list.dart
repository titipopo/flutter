import 'dart:developer';

import 'package:flutter/material.dart';

enum Menu { preview, share, getLink, remove, download }

class SongsList extends StatefulWidget {
  const SongsList({super.key});

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          hoverColor: Colors.amber,
          onTap: ()=>{ log('Tapped')},
          trailing: PopupMenuButton<Menu>(
            popUpAnimationStyle: AnimationStyle.noAnimation,
            icon: const Icon(Icons.more_vert),
            onSelected: (Menu item) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem<Menu>(
                value: Menu.preview,
                child: ListTile(
                  leading: Icon(Icons.visibility_outlined),
                  title: Text('Preview'),
                ),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.share,
                child: ListTile(
                  leading: Icon(Icons.share_outlined),
                  title: Text('Share'),
                ),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.getLink,
                child: ListTile(
                  leading: Icon(Icons.link_outlined),
                  title: Text('Get link'),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<Menu>(
                value: Menu.remove,
                child: ListTile(
                  leading: Icon(Icons.delete_outline),
                  title: Text('Remove'),
                ),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.download,
                child: ListTile(
                  leading: Icon(Icons.download_outlined),
                  title: Text('Download'),
                ),
              ),
            ],
          ),
          title: Text(
            'Song Name$index',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('Artist Name$index',
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        );
      },
      itemCount: 20,
    );
  }
}
