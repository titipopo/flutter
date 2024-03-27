import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void getdata() async {
     final document = await FirebaseFirestore.instance
        .collection('message') 
        .doc('OfiN78dnxtUi7yZRfiX9tmCiFai1')
        .collection('messages')
        .orderBy('sentAt')
        .get();
     
     print(document);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Chat'));
  }
}
