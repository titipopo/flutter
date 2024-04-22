import 'package:chatapp/src/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final String? id;
  final Timestamp? createdAt;
  final String? createdBy;
  final String? imageUrl;
  final List<String>? members;
  final String? name;
  final MessageModel? recentMessage;
  final int? type;
  GroupModel({
    this.id,
    this.createdAt,
    this.createdBy,
    this.imageUrl,
    this.members,
    this.name,
    this.recentMessage,
    this.type,
  });

  factory GroupModel.fromJson(Map<String, dynamic>? data) {
    return GroupModel(
      id: data?['id'],
      createdAt: data?['createdAt'],
      createdBy: data?['createdBy'],
      imageUrl: data?['imageUrl'],
      name: data?['name'],
      recentMessage: MessageModel.fromJsonGroup(data?['recentMessage']),
      members:
          data?['members'] is Iterable ? List.from(data?['members']) : null,
      type: data?['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) "id": id,
      if (createdAt != null) "createdAt": createdAt,
      if (createdBy != null) "createdBy": createdBy,
      if (imageUrl != null) "imageUrl": imageUrl,
      if (name != null) "name": name,
      if (recentMessage != null) "recentMessage": recentMessage?.toJsonGroup(),
      if (members != null) "members": members,
      if (type != null) "type": type,
    };
  }
}
