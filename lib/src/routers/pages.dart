import 'package:chatapp/src/screens/auth/sign_in.dart';
import 'package:chatapp/src/screens/auth/sign_up.dart';
import 'package:chatapp/src/screens/home/main.dart';
import 'package:chatapp/src/routers/routers.dart';
import 'package:chatapp/src/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';

class AppPages {
  static List<PageEntity> routers() {
    return [
      PageEntity(
        router: AppRouters.intiial,
        page: const WelcomeScreen(),
      ),
      PageEntity(
        router: AppRouters.signIn,
        page: const SigninScreen(),
      ),
      PageEntity(
        router: AppRouters.register,
        page: const SignupScreen(),
      ),
      PageEntity(
        router: AppRouters.application,
        page: const MainScreen(),
      )
    ];
  }

  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routers()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRouterSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result =
          routers().where((element) => element.router == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }

    return MaterialPageRoute(
        builder: (_) => const SigninScreen(), settings: settings);
  }
}

class PageEntity {
  String router;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.router,
    required this.page,
    this.bloc,
  });
}
