import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void getdata(BuildContext context) async {
    final document = await FirebaseFirestore.instance
        .collection('group')
        .where('members', arrayContains: 'OfiN78dnxtUi7yZRfiX9tmCiFai1')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        log(doc["name"]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          getdata(context);
        },
        child: const Text('Getdata'));
  }
}
