import 'package:flutter/material.dart';

class NowPlayingModel extends StatefulWidget {
  const NowPlayingModel({super.key});

  @override
  State<NowPlayingModel> createState() => _NowPlayingModelState();
}

class _NowPlayingModelState extends State<NowPlayingModel> {
  double y = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.pink,
            ),
            width: 300,
            height: 300,
          ),
          const Column(
            children: [
              Text(
                'Song Name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Artist name goes here',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Column(
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Theme.of(context).colorScheme.primary,
                  inactiveTrackColor: Colors.white,
                  thumbColor: Theme.of(context).colorScheme.primary, 
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                  overlayColor: Theme.of(context).colorScheme.primary,
                ),
                child: Slider(
                  value: y,
                  min: 0,
                  max: 100,
                  onChanged: (newValue) {
                    setState(() {
                      y = newValue;
                    });
                  },
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '00:13',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '00:13',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RawMaterialButton(
                  onPressed: () {},
                  shape: const CircleBorder(),
                  constraints:
                      const BoxConstraints(minHeight: 50, minWidth: 50),
                  child:  Icon(
                    Icons.skip_previous,
                    color: Theme.of(context).colorScheme.primary,
                    size: 50,
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  fillColor: Theme.of(context).colorScheme.primary,
                  shape: const CircleBorder(),
                  constraints:
                      const BoxConstraints(minHeight: 80, minWidth: 80),
                  child: const Icon(
                    Icons.pause,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  shape: const CircleBorder(),
                  constraints:
                      const BoxConstraints(minHeight: 50, minWidth: 50),
                  child:  Icon(
                    Icons.skip_next,
                    color: Theme.of(context).colorScheme.primary,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon:  Icon(
                  Icons.favorite_border,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon:  Icon(
                  Icons.shuffle,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
