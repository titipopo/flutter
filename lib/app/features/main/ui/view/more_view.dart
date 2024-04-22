import 'package:chatapp/app/features/auth/ui/cubit/authentication_cubit.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/core/navigation/routers_names.dart';
import 'package:chatapp/core/utils/section_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthenticationCubit>();
    String displayName = authCubit.state.user.name ?? '';
    String email = authCubit.state.user.email ?? '';
    String avatar = authCubit.state.user.imageUrl ?? '';
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          SectionContainer(children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                CircleAvatar(
                  minRadius: 40,
                  maxRadius: 50,
                  backgroundColor: Theme.of(context).colorScheme.outline,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(avatar),
                    minRadius: 38,
                    maxRadius: 48,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(email),
                  ],
                ),
              ]),
            ),
          ]),
          SectionContainer(children: [
            ListTile(
              onTap: () =>
                  {context.go('${AppRouters.more}/${AppRouters.profile}')},
              trailing: const Icon(Icons.navigate_next),
              leading: const Icon(Icons.person),
              title: Text(
                AppLocalizations.of(context).moreProfile,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () =>
                  context.go('${AppRouters.more}/${AppRouters.settings}'),
              trailing: const Icon(Icons.navigate_next),
              leading: const Icon(Icons.settings),
              title: Text(
                AppLocalizations.of(context).moreSettings,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ]),
          ElevatedButton(
              onPressed: () => authCubit.signOut(),
              child: Text(AppLocalizations.of(context).profileLogout))
        ]));
  }
}
