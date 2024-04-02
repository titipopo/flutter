import 'package:chatapp/src/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Text('Profiles'),
        BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
          if (state.status == AuthStatus.signout) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              'login',
              (route) => false,
            );
          }
        }, builder: (context, state) {
          return ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  SignOut(),
                );
              },
              child: const Text('logOut'));
        })
      ],
    ));
  }
}
