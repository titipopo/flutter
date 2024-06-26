import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/app/features/more/ui/cubit/settings_cubit.dart';
import 'package:chatapp/core/navigation/routers_names.dart';
import 'package:chatapp/core/utils/page_name.dart';
import 'package:chatapp/core/utils/section.dart';
import 'package:chatapp/core/utils/section_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum Language { en, vi, jp }

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
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
        return AppLocalizations.of(context).en;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = context.read<SettingsCubit>().state.themeMode;
    language = getlanguageName(Localizations.localeOf(context).toString());
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  PageName(
                    name: AppLocalizations.of(context).settings,
                    child: IconButton(
                        onPressed: () {
                          context.go(AppRouters.more);
                        },
                        icon: const Icon(Icons.navigate_before)),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context).theme,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .fontSize)),
                            ],
                          ),
                          SectionContainer(children: [
                            Section(
                              label: AppLocalizations.of(context).darkTheme,
                              child: Switch(
                                value:
                                    themeMode == ThemeMode.dark ? true : false,
                                thumbIcon: MaterialStatePropertyAll(Icon(
                                  themeMode == ThemeMode.dark
                                      ? Icons.dark_mode
                                      : Icons.light_mode,
                                  color: Theme.of(context).iconTheme.color,
                                )),
                                onChanged: (bool value) {
                                  setState(() {
                                    light = value;
                                  });
                                  context
                                      .read<SettingsCubit>()
                                      .toggleTheme(isDarkTheme: light);
                                },
                              ),
                            )
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context).languageSetting,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .fontSize)),
                            ],
                          ),
                          SectionContainer(children: [
                            Section(
                                label: AppLocalizations.of(context).language,
                                child: Row(children: [
                                  Text(language),
                                  PopupMenuButton<Language>(
                                    popUpAnimationStyle:
                                        AnimationStyle.noAnimation,
                                    icon: const Icon(Icons.navigate_next),
                                    onSelected: (Language item) {
                                      switch (item) {
                                        case Language.en:
                                          context
                                              .read<SettingsCubit>()
                                              .changeLanguage(item.name);
                                        case Language.vi:
                                          context
                                              .read<SettingsCubit>()
                                              .changeLanguage(item.name);
                                        case Language.jp:
                                          context
                                              .read<SettingsCubit>()
                                              .changeLanguage(item.name);
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<Language>>[
                                      PopupMenuItem<Language>(
                                        value: Language.en,
                                        child: Text(
                                            AppLocalizations.of(context).en),
                                      ),
                                      PopupMenuItem<Language>(
                                        value: Language.vi,
                                        child: Text(
                                            AppLocalizations.of(context).vi),
                                      ),
                                      PopupMenuItem<Language>(
                                        value: Language.jp,
                                        child: Text(
                                            AppLocalizations.of(context).jp),
                                      ),
                                    ],
                                  ),
                                ]))
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context).about,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .fontSize)),
                            ],
                          ),
                          SectionContainer(children: [
                            Section(
                                label: AppLocalizations.of(context).version,
                                child: const Text('1.0')),
                            const Divider(),
                            Section(
                              label: AppLocalizations.of(context).auth,
                              child: const Text('From Titipopo with ♡'),
                            )
                          ]),
                        ],
                      )),
                ]))));
  }
}
