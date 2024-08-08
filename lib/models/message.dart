import 'package:loklokapp/constants.dart';

class Message {
  final String message;
  final String userId;
  final int createdAt;

  Message(this.message, this.userId, this.createdAt);
  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage], jsonData[kId], jsonData[kCreatedAt]);
  }
}
