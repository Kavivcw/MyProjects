import 'package:flutter/cupertino.dart';

class ChatMessage{
  String messageContent;
  String messageType;

  ChatMessage({
    required this.messageContent,
    required this.messageType,

  });
}


class ChatMessageApi {
  late String converesationId;
  late String sender;
  late String text;
  late String createdAt;
  late String updatedAt;


  ChatMessageApi(
      {
        required this.converesationId,
        required this.sender,
        required this.text,
        required this.createdAt,
        required this.updatedAt,

      });

  ChatMessageApi.fromJson(Map<String, dynamic> json) {
    converesationId = json['converesationId']??"";
    sender = json['sender']??"";
    text = json['text']??"";
    createdAt = json['createdAt']??"";
    updatedAt = json['updatedAt']??"";

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['converesationId'] = this.converesationId;
    data['sender'] = this.sender;
    data['text'] = this.text;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;

    return data;
  }
}

