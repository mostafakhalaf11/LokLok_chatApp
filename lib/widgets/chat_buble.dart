import 'package:flutter/material.dart';
import 'package:loklokapp/models/message.dart';
import '../constants.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          color: kBubleColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(color: kTextColor),
        ),
      ),
    );
  }
}

class ChatBubleForAfriend extends StatelessWidget {
  const ChatBubleForAfriend({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(color: kTextColor),
        ),
      ),
    );
  }
}
