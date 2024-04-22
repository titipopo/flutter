import 'package:flutter/material.dart';

class NowPlayingFullScreen extends StatefulWidget {
  const NowPlayingFullScreen({super.key});

  @override
  State<NowPlayingFullScreen> createState() => _NowPlayingFullScreenState();
}

class _NowPlayingFullScreenState extends State<NowPlayingFullScreen> {
  double _percent = 0;
  bool _fav = false;
  bool _repeat = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pink,
                ),
                width: 400,
                height: 400,
              ),
              const Column(
                children: [
                  Text(
                    'Song Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Artist name goes here',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _fav = !_fav;
                      });
                    },
                    icon: Icon(
                      _fav ? Icons.favorite : Icons.favorite_border,
                    ),
                  ),
                  Slider(
                    value: _percent,
                    min: 0,
                    max: 100,
                    onChanged: (newValue) {
                      setState(() {
                        _percent = newValue;
                      });
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '00:13',
                      ),
                      Text(
                        '00:13',
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {},
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.shuffle,
                    ),
                  )),
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {},
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.skip_previous,
                    ),
                  )),
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {},
                    fillColor: Theme.of(context).colorScheme.secondary,
                    shape: const CircleBorder(),
                    constraints: const BoxConstraints(minHeight: 100),
                    child: const Icon(
                      Icons.pause,
                      size: 60,
                    ),
                  )),
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {},
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.skip_next,
                    ),
                  )),
                  Expanded(
                      child: RawMaterialButton(
                    hoverColor: Colors.amber,
                    onPressed: () {
                      setState(() {
                        _repeat = !_repeat;
                      });
                    },
                    shape: const CircleBorder(),
                    child: Icon(
                      _repeat ? Icons.repeat : Icons.repeat_one,
                    ),
                  )),
                ],
              ),
            ],
          ),
        ));
  }
}
