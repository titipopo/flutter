import 'package:chatapp/app/features/auth/ui/cubit/sign_in_cubit.dart';
import 'package:chatapp/app/features/auth/ui/view/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignInCubit>(
        create: (context) => SignInCubit(),
        child: const SigninView(),
      ),
    );
  }
}
