import 'dart:developer';

import 'package:chatapp/app/features/auth/ui/cubit/authentication_cubit.dart';
import 'package:chatapp/core/navigation/routers_names.dart';
import 'package:chatapp/app/features/auth/ui/signin.dart';
import 'package:chatapp/src/screens/bottom_nav/calendar.dart';
import 'package:chatapp/src/screens/bottom_nav/chat.dart';
import 'package:chatapp/src/screens/bottom_nav/home.dart';
import 'package:chatapp/src/screens/bottom_nav/bottom_nav.dart';
import 'package:chatapp/app/features/main/ui/more.dart';
import 'package:chatapp/src/screens/bottom_nav/musics.dart';
import 'package:chatapp/src/screens/chats/chats_details.dart';
import 'package:chatapp/src/screens/chats/create_conversation.dart';
import 'package:chatapp/app/features/more/ui/profiles.dart';
import 'package:chatapp/app/features/more/ui/settings.dart';
import 'package:chatapp/src/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _tabANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'tabANav');

class AppRoutes {
  static GoRouter getRouters(int onboard) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: onboard == 1 ? AppRouters.start : AppRouters.signIn,
      redirect: (context, state) async {
         final authState = context.read<AuthenticationCubit>().state;
         
        if (authState.status == AuthenticationStatus.unauthenticated) {
          return AppRouters.signIn;
        }
        if (state.matchedLocation == AppRouters.signIn) {
          return AppRouters.home;
        }

        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: AppRouters.start,
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: AppRouters.signIn,
          builder: (context, state) => const SigninScreen(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return MainScreen(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRouters.home,
                  builder: (context, state) => const HomeScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRouters.calendar,
                  builder: (context, state) => const CalendarScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRouters.musics,
                  builder: (context, state) => const MusicsScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRouters.chats,
                  builder: (context, state) => const ChatScreen(),
                  routes: [
                    GoRoute(
                      path: AppRouters.chatDetails,
                      name: AppRouters.chatDetails,
                      parentNavigatorKey: _rootNavigatorKey,
                      pageBuilder: (context, state) => NoTransitionPage<void>(
                          key: state.pageKey,
                          child: ChatDetailsScreen(
                            groupId: state.uri.queryParameters['groupId'],
                            groupType: state.uri.queryParameters['groupType'],
                            groupName: state.uri.queryParameters['groupName'],
                          )),
                    ),
                    GoRoute(
                      path: AppRouters.createConversation,
                      name: AppRouters.createConversation,
                      parentNavigatorKey: _rootNavigatorKey,
                      pageBuilder: (context, state) => NoTransitionPage<void>(
                          key: state.pageKey,
                          child: const CreateConversationScreen()),
                    )
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRouters.more,
                  builder: (context, state) => const MoreScreen(),
                  routes: [
                    GoRoute(
                      path: AppRouters.profile,
                      parentNavigatorKey: _rootNavigatorKey,
                      //builder: (context, state) => const ProfileScreen(),
                      pageBuilder: (context, state) => NoTransitionPage<void>(
                          key: state.pageKey, child: const ProfileScreen()),
                    ),
                    GoRoute(
                      path: AppRouters.settings,
                      parentNavigatorKey: _rootNavigatorKey,
                      //builder: (context, state) => const SettingsScreen(),
                      pageBuilder: (context, state) => NoTransitionPage<void>(
                          key: state.pageKey, child: const SettingsScreen()),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
