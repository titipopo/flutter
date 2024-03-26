import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/src/cubit/language_cubit.dart';
import 'package:chatapp/src/cubit/theme_cubit.dart';
import 'package:chatapp/src/utils/page_name.dart';
import 'package:chatapp/src/utils/section.dart';
import 'package:chatapp/src/utils/settings_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Menu { en, vi, jp }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool light = true;
  String language = "";

  String getlanguageName(String locale) {
    switch (locale) {
      case "en":
        return AppLocalizations.of(context).en;
      case "vi":
        return AppLocalizations.of(context).vi;
      case "jp":
        return AppLocalizations.of(context).jp;
      default:
        return AppLocalizations.of(context).vi;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = context.read<ThemeCubit>().state;
    language = getlanguageName(Localizations.localeOf(context).toString());
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          PageName(name: AppLocalizations.of(context).settings),
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
                          Text(language),
                          PopupMenuButton<Menu>(
                            popUpAnimationStyle: AnimationStyle.noAnimation,
                            icon: const Icon(Icons.navigate_next),
                            onSelected: (Menu item) {
                              switch (item) {
                                case Menu.en:
                                  context.read<LanguageCubit>().toEnglish();
                                case Menu.vi:
                                  context.read<LanguageCubit>().toVietNamese();
                                case Menu.jp:
                                  context.read<LanguageCubit>().toJapanese();
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<Menu>>[
                              PopupMenuItem<Menu>(
                                value: Menu.en,
                                child: Text(AppLocalizations.of(context).en),
                              ),
                              PopupMenuItem<Menu>(
                                value: Menu.vi,
                                child: Text(AppLocalizations.of(context).vi),
                              ),
                              PopupMenuItem<Menu>(
                                value: Menu.jp,
                                child: Text(AppLocalizations.of(context).jp),
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
