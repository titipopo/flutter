import 'package:chatapp/app/features/auth/ui/cubit/sign_in_cubit.dart';
import 'package:chatapp/app/shared/ui/app_button.dart';
import 'package:chatapp/app/shared/ui/app_dialog.dart';
import 'package:chatapp/core/utils/data_response.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/core/navigation/routers_names.dart';
import 'package:chatapp/core/utils/ball_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SigninView extends StatefulWidget {
  const SigninView({
    super.key,
  });

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Text Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;

  bool validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInCubit = context.read<SignInCubit>();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        AuthScreenWidget(
                            title: AppLocalizations.of(context).login),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context).email,
                                  hintText:
                                      AppLocalizations.of(context).emailHint,
                                  prefixIcon: const Icon(Icons.email_rounded),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)
                                        .emailError;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context).password,
                                  hintText:
                                      AppLocalizations.of(context).passwordHint,
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(_obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)
                                        .passwordError;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              BlocConsumer<SignInCubit, SignInState>(
                                listener: (context, state) {
                                  if (state.status.isError) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AlertDialog(
                                            content: Text('error'),
                                          );
                                        });
                                  } else if (state.status.isSuccess) {
                                    context.go(AppRouters.home);
                                  } else {
                                    AppDialog.showAppDialog(
                                      context,
                                      const SizedBox(
                                        height: 100,
                                        width: 70,
                                        child: Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      AppIconButton(
                                        text:
                                            AppLocalizations.of(context).login,
                                        color: Colors.black,
                                        icon: const FaIcon(
                                            FontAwesomeIcons.envelope,
                                            size: 24),
                                        onPressed: () =>
                                            signInCubit.signInWithEmail(
                                                _emailController.text.trim(),
                                                _passwordController.text
                                                    .trim()),
                                      ),
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .forgotPassword,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          context.go(AppRouters.register);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context).newHere,
                                        ),
                                      ),
                                      const Divider(),
                                      const Text(
                                        'Continue with',
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(child: 
                                          AppIconButton(
                                            text: 'Google',
                                            color: Colors.black,
                                            icon: const FaIcon(
                                                FontAwesomeIcons.google,
                                                size: 24),
                                            onPressed:
                                                signInCubit.signInWithGoogle,
                                          )),
                                          const SizedBox(width: 10,),
                                         Expanded(child:  AppIconButton(
                                            text: 'GitHub',
                                            icon: const FaIcon(
                                                FontAwesomeIcons.github,
                                                size: 24),
                                            onPressed:
                                                signInCubit.signInWithGithub,
                                            color: Colors.black,
                                          )),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))),
        ));
  }
}
