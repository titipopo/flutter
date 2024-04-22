import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/src/bloc/auth_bloc.dart';
import 'package:chatapp/core/navigation/routers_names.dart';
import 'package:chatapp/core/utils/page_name.dart';
import 'package:chatapp/core/utils/section_container.dart';
import 'package:chatapp/core/utils/vertical_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _readonly = true;
  late bool _editable;
  FocusNode nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _editable = _readonly;
  }

  @override
  Widget build(BuildContext context) {
    String displayName = context.read<AuthBloc>().state.user?.displayName ?? '';
    String email = context.read<AuthBloc>().state.user?.email ?? '';
    String id = context.read<AuthBloc>().state.user?.id ?? '';
    String avatar = context.read<AuthBloc>().state.user?.photoURL ?? '';
    DateTime? creationTime =
        context.read<AuthBloc>().state.user!.metadata?.creationTime;
    DateTime? lastSignInTime =
        context.read<AuthBloc>().state.user!.metadata?.lastSignInTime;
    String strCreationTime = creationTime != null
        ? DateFormat(AppLocalizations.of(context).dateFormatYMD)
            .format(creationTime)
        : '';
    String strLastSignInTime = lastSignInTime != null
        ? DateFormat(AppLocalizations.of(context).dateFormatYMD)
            .format(lastSignInTime)
        : '';

    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      PageName(
        name: AppLocalizations.of(context).profiles,
        child: IconButton(
            onPressed: () {
              context.go(AppRouters.more);
            },
            icon: const Icon(Icons.navigate_before)),
      ),
      SingleChildScrollView(
          child: Column(children: [
        CircleAvatar(
          radius: 100, // Image radius
          backgroundImage: NetworkImage(avatar),
        ),
        SectionContainer(children: [
          VerticalSection(
            label: AppLocalizations.of(context).profileName,
            isInput: true,
            child: TextFormField(
              readOnly: _readonly,
              initialValue: displayName,
              focusNode: nameFocus,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(_editable ? Icons.edit_off : Icons.edit),
                  onPressed: () {
                    setState(() {
                      _readonly = false;
                    });
                    FocusScope.of(context).requestFocus(nameFocus);
                  },
                ),
              ),
            ),
          ),
          VerticalSection(
            label: AppLocalizations.of(context).profileEmail,
            isInput: true,
            child: TextFormField(
              readOnly: _readonly,
              initialValue: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(_editable ? Icons.edit_off : Icons.edit),
                  onPressed: () {
                    setState(() {
                      _readonly = false;
                    });
                  },
                ),
              ),
            ),
          ),
          VerticalSection(
            label: AppLocalizations.of(context).profileId,
            child: GestureDetector(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: id));
                },
                child: Text(id)),
          ),
          VerticalSection(
            label: AppLocalizations.of(context).profileJoinedOn,
            child: Text(strCreationTime),
          ),
          VerticalSection(
            label: AppLocalizations.of(context).profileLastLogin,
            child: Text(strLastSignInTime),
          ),
        ]),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          child: ElevatedButton(
            onPressed: () => BlocProvider.of<AuthBloc>(context).add(
              SignOut(),
            ),
            child: Text(AppLocalizations.of(context).profileLogout),
          ),
        )
      ]))
    ])));
  }
}
