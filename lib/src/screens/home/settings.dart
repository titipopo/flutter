import 'package:chatapp/src/cubit/theme_cubit.dart';
import 'package:chatapp/src/utils/page_name.dart';
import 'package:chatapp/src/utils/section.dart';
import 'package:chatapp/src/utils/settings_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Menu { english, vietmamese }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = context.read<ThemeCubit>().state;
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          const PageName(name: 'Settings'),
          const SizedBox(
            height: 10,
          ),
          Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Theme Mode',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .fontSize)),
                    ],
                  ),
                  SettingsContainer(child: [
                    Section(
                      label: 'Dark Mode',
                      child: Switch(
                        value: themeMode == ThemeMode.dark ? true : false,
                        thumbIcon: MaterialStatePropertyAll(Icon(
                            themeMode == ThemeMode.dark
                                ? Icons.dark_mode
                                : Icons.light_mode)),
                        onChanged: (bool value) {
                          setState(() {
                            light = value;
                          });
                          context
                              .read<ThemeCubit>()
                              .toggleTheme(isDarkTheme: light);
                        },
                      ),
                    )
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Language Settings',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .fontSize)),
                    ],
                  ),
                  SettingsContainer(child: [
                    Section(
                        label: 'Language',
                        child: Row(children: [
                          Text(Localizations.localeOf(context).toString()),
                          PopupMenuButton<Menu>(
                            popUpAnimationStyle: AnimationStyle.noAnimation,
                            icon: const Icon(Icons.navigate_next),
                            onSelected: (Menu item) {},
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<Menu>>[
                              const PopupMenuItem<Menu>(
                                value: Menu.english,
                                child: Text('English'),
                              ),
                              const PopupMenuItem<Menu>(
                                value: Menu.vietmamese,
                                child: Text('Vietnamese'),
                              ),
                            ],
                          ),
                        ]))
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('About',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .fontSize)),
                    ],
                  ),
                  const SettingsContainer(child: [
                    Section(label: 'Version', child: Text('1.0')),
                    Divider(),
                    Section(
                      label: 'Author',
                      child: Text('From Titipopo with ♡'),
                    )
                  ]),
                ],
              )),
        ]));
  }
}
