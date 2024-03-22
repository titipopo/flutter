import 'package:chatapp/src/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    ThemeMode test = context.read<ThemeCubit>().state;
    print('state is $test');
    return Center(
        child: Column(children: [
      const Text('Settings'),
      Switch(
        value: test == ThemeMode.dark ? true : false,
        thumbIcon: MaterialStatePropertyAll(
            Icon(test == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode)),
        onChanged: (bool value) {
          setState(() {
            light = value;
          });
          context.read<ThemeCubit>().toggleTheme(isDarkTheme: light);
        },
      ),
    ]));
  }
}
