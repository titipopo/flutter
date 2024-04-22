import 'package:chatapp/core/navigation/routers_names.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/src/bloc/auth_bloc.dart';
import 'package:chatapp/app/features/auth/ui/signin.dart';
import 'package:chatapp/core/utils/ball_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupView extends StatefulWidget {
  const SignupView({
    super.key,
  });

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Text Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = false;

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
                            title: AppLocalizations.of(context).register),
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
                              BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {
                                  if (state.status == AuthStatus.signup) {
                                    context.go(AppRouters.auth);
                                  } else if (state.status == AuthStatus.error) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AlertDialog(
                                            content: Text('error'),
                                          );
                                        });
                                  }
                                },
                                builder: (context, state) {
                                  return SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (!validateAndSave()) return;
                                        BlocProvider.of<AuthBloc>(context).add(
                                          SignUp(
                                            _emailController.text.trim(),
                                            _passwordController.text.trim(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        AppLocalizations.of(context).register,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              const SigninScreen(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context).hasAccount,
                                ),
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
