import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? messageText;
  final String? sentBy;
  final DateTime? sentAt;
  MessageModel({
    required this.messageText,
    required this.sentBy,
    required this.sentAt,
  });

   factory MessageModel.fromJson(
    Map<String, dynamic>? data
  ) {
    return MessageModel(
      messageText: data?['messageText'],
      sentAt: DateTime.fromMillisecondsSinceEpoch(data?['sentAt'].millisecondsSinceEpoch, isUtc: true).add(const Duration(hours: 9)),
      sentBy: data?['sentBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (messageText != null) "messageText": messageText,
      if (sentAt != null) "sentAt": sentAt,
      if (sentBy != null) "sentBy": sentBy,
    };
  }

  Map<String, dynamic> toJsonGroup() {
    return {
      if (messageText != null) "messageText": messageText,
      if (sentAt != null) "recentMessageSentAt": sentAt,
      if (sentBy != null) "recentMessageSendBy": sentBy,
    };
  }

  factory MessageModel.fromJsonGroup(
    Map<String, dynamic>? data
  ) {
    return MessageModel(
      messageText: data?['messageText'],
      sentAt:  DateTime.fromMillisecondsSinceEpoch(data?['recentMessageSentAt'].millisecondsSinceEpoch, isUtc: true).add(const Duration(hours: 9)),
      sentBy: data?['recentMessageSendBy'],
    );
  }
}
