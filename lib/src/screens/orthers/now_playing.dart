import 'package:chatapp/src/screens/orthers/now_playing_%20model._screen.dart';
import 'package:flutter/material.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  Future showNowPlayingModelSheet(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return const NowPlayingModel();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration:  BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onVerticalDragStart: (drag) {
              showNowPlayingModelSheet(context);
            },
            onTap: () {
              showNowPlayingModelSheet(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        width: 45,
                        height: 45,
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Song Name',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Artist Name',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.pause,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
