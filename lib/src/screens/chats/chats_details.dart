import 'dart:developer';

import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/src/bloc/auth_bloc.dart';
import 'package:chatapp/src/models/group.dart';
import 'package:chatapp/src/models/message.dart';
import 'package:chatapp/src/models/user.dart';
import 'package:chatapp/core/navigation/routers_names.dart';
import 'package:chatapp/src/screens/chats/message_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen(
      {super.key, this.groupId, this.groupType, this.groupName});

  final String? groupId;
  final String? groupType;
  final String? groupName;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final _messageController = TextEditingController();
  final List<MessageModel> _messages = [];

  Future<void> sendMessage(String userId) async {
    MessageModel message = MessageModel(
      messageText: _messageController.text.trim(),
      sentBy: userId,
      sentAt: DateTime.now(),
    );
    GroupModel group = GroupModel(recentMessage: message);
    await FirebaseFirestore.instance
        .collection('message')
        .doc(widget.groupId)
        .collection('messages')
        .add(message.toJson())
        .then(
      (querySnapshot) {
        log("Message: ${querySnapshot.id}");
      },
      onError: (e) => log("Error completing: $e"),
    );

    await FirebaseFirestore.instance
        .collection('group')
        .doc(widget.groupId)
        .update(group.toJson())
        .then(
      (querySnapshot) {
        log("Group");
      },
      onError: (e) => log("Error completing: $e"),
    );

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    String id = context.read<AuthBloc>().state.user?.id ?? '';
    bool isPrivate = widget.groupType == '2';

    final now = DateTime.now();

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context.go(AppRouters.chats);
                        },
                        icon: const Icon(Icons.navigate_before)),
                    Text(widget.groupName!,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headlineLarge!.fontSize,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),),
                  ],
                )),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('message')
                        .doc(widget.groupId)
                        .collection('messages')
                        .orderBy('sentAt', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      _messages.clear();
                      for (var e in snapshot.data!.docs) {
                        Map<String, dynamic> data =
                            e.data() as Map<String, dynamic>;
                        var model = MessageModel.fromJson(data);

                        _messages.add(model);
                      }

                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              reverse: true,
                              shrinkWrap: true,
                              itemCount: _messages.length,
                              padding: const EdgeInsets.all(10.0),
                              itemBuilder: (context, index) {
                                var sentAt = _messages[index].sentAt!;
                                var sentBy = _messages[index].sentBy;
                                var messageText = _messages[index].messageText!;
                                var hhmm = DateFormat('HH:mm').format(sentAt);
                                _messages[index].messageText!;

                                var strDate = DateFormat(
                                        AppLocalizations.of(context)
                                            .dateFormatYMDE,
                                        Localizations.localeOf(context)
                                            .toString())
                                    .format(sentAt);

                                bool isSender = sentBy == id;
                                bool isSameDate = false;

                                final DateTime date =
                                    DateTime.parse(sentAt.toString());

                                if (_messages.length > 2 && index == 0) {
                                  final DateTime prevDate = DateTime.parse(
                                      _messages[index + 1].sentAt.toString());
                                  isSameDate = date.isSameDate(prevDate);
                                } else if (index == _messages.length - 1) {
                                  isSameDate = false;
                                } else {
                                  final DateTime prevDate = DateTime.parse(
                                      _messages[index + 1].sentAt.toString());
                                  isSameDate = date.isSameDate(prevDate);
                                }

                                if (now.isSameDate(date)) {
                                  strDate = 'Today';
                                } else if (DateUtils.dateOnly(now)
                                        .difference(DateUtils.dateOnly(date))
                                        .inDays ==
                                    1) {
                                  strDate = 'Yesterday';
                                }

                                return FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(sentBy)
                                        .get(),
                                    builder: (_, userSnapshot) {
                                      var avatar = UserModel.fromJson(
                                              userSnapshot.data?.data())
                                          .photoURL;
                                      var name = UserModel.fromJson(
                                              userSnapshot.data?.data())
                                          .displayName;
                                      var email = UserModel.fromJson(
                                              userSnapshot.data?.data())
                                          .email;

                                      name ??= '';
                                      email ??= '';

                                      if (name.isEmpty) {
                                        name = email;
                                      }

                                      avatar ??=
                                          'https://ui-avatars.com/api/?background=random&rounded=true&bold=true&name=${name}';

                                      return Column(
                                        children: [
                                          Visibility(
                                            visible: !isSameDate,
                                            child: Text(strDate),
                                          ),
                                          Row(
                                              mainAxisAlignment: isSender
                                                  ? MainAxisAlignment.end
                                                  : MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Visibility(
                                                  visible: isSender,
                                                  child: Column(children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5.0,
                                                              bottom: 5.0),
                                                      child: Text(hhmm,
                                                          style: TextStyle(
                                                              fontSize: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall!
                                                                  .fontSize)),
                                                    )
                                                  ]),
                                                ),
                                                Row(
                                                  children: [
                                                    Visibility(
                                                      visible: !isSender,
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                avatar),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: isSender
                                                          ? CrossAxisAlignment
                                                              .end
                                                          : CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Visibility(
                                                          visible: isPrivate,
                                                          child: Text(
                                                            name,
                                                            style: const TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        ClipPath(
                                                            clipper: MyClipper(
                                                                isSender:
                                                                    isSender),
                                                            child:
                                                                MessageContainer(
                                                              mediaWidth:
                                                                  mediaWidth,
                                                              isSender:
                                                                  isSender,
                                                              child: Text(
                                                                  messageText),
                                                            )),
                                                      ],
                                                    ),
                                                    Visibility(
                                                      visible: isSender,
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                avatar),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Visibility(
                                                  visible: !isSender,
                                                  child: Column(children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              bottom: 5.0),
                                                      child: Text(hhmm,
                                                          style: TextStyle(
                                                              fontSize: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall!
                                                                  .fontSize)),
                                                    )
                                                  ]),
                                                ),
                                              ]),
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                        ],
                      );
                    })),
            Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {},
                    ),
                    Expanded(
                        child: TextFormField(
                      onTapOutside: (PointerDownEvent event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: _messageController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).emailHint,
                      ),
                      onEditingComplete: () => sendMessage(id),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context).emailError;
                        }
                        return null;
                      },
                    )),
                    IconButton(
                      icon: const Icon(Icons.mic),
                      onPressed: () {},
                    ),
                  ],
                ))
          ],
        )));
  }
}

String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}

class MyClipper extends CustomClipper<Path> {
  final bool isSender;
  MyClipper({required this.isSender});
  @override
  Path getClip(Size size) {
    var path = Path();
    double radius = 10.0;
    double nipSize = 8.0;
    double sizeRatio = 2.0;
    if (isSender) {
      path.lineTo(size.width - radius - nipSize, 0);
      path.arcToPoint(Offset(size.width - nipSize, radius),
          radius: Radius.circular(radius));

      path.lineTo(size.width - nipSize, size.height - sizeRatio * nipSize);

      path.lineTo(size.width - nipSize / sizeRatio, size.height - nipSize);

      path.quadraticBezierTo(size.width, size.height, size.width - nipSize,
          size.height - nipSize / sizeRatio);

      path.lineTo(size.width - nipSize, size.height - nipSize / sizeRatio);

      path.lineTo(size.width - sizeRatio * nipSize, size.height - nipSize);

      path.lineTo(radius, size.height - nipSize);

      path.arcToPoint(Offset(0, size.height - radius - nipSize),
          radius: Radius.circular(radius));

      path.lineTo(0, radius);
      path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
    } else {
      path.lineTo(size.width - radius, 0);
      path.arcToPoint(Offset(size.width, radius),
          radius: Radius.circular(radius));
      path.lineTo(size.width, size.height - radius - nipSize);
      path.arcToPoint(Offset(size.width - radius, size.height - nipSize),
          radius: Radius.circular(radius));

      path.lineTo(sizeRatio * nipSize, size.height - nipSize);

      path.lineTo(nipSize, size.height - nipSize / sizeRatio);

      path.quadraticBezierTo(
          0, size.height, nipSize / sizeRatio, size.height - nipSize);

      path.lineTo(nipSize / sizeRatio, size.height - nipSize);

      path.lineTo(nipSize, size.height - sizeRatio * nipSize);

      path.lineTo(nipSize, radius);
      path.arcToPoint(Offset(radius + nipSize, 0),
          radius: Radius.circular(radius));
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
