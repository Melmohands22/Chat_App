import 'package:chat_app/constant.dart';
import 'package:chat_app/models/messageModel.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;
  static const Color primaryColor = Colors.blue; // Define your primary color

  @override
  Widget build(BuildContext context) {
    const double horizontalMargin = 16;
    const double verticalMargin = 16;
    const double contentPaddingLeft = 16;
    const double contentPaddingTop = 28;
    const double contentPaddingBottom = 28;
    const double contentPaddingRight = 32;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: horizontalMargin, vertical: verticalMargin),
        padding: const EdgeInsets.fromLTRB(
          contentPaddingLeft,
          contentPaddingTop,
          contentPaddingRight,
          contentPaddingBottom,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: KpraimaryColor,
        ),
        child: Text(
          message.message,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    const double horizontalMargin = 16;
    const double verticalMargin = 16;
    const double contentPaddingLeft = 16;
    const double contentPaddingTop = 28;
    const double contentPaddingBottom = 28;
    const double contentPaddingRight = 32;
    const Color bubbleColor = Color(0xff006d84);
    const Color textColor = Colors.white;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin, vertical: verticalMargin),
        padding: EdgeInsets.fromLTRB(
          contentPaddingLeft,
          contentPaddingTop,
          contentPaddingRight,
          contentPaddingBottom,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: bubbleColor,
        ),
        child: Text(
          message.message,
          style: TextStyle(fontSize: 18, color: textColor),
        ),
      ),
    );
  }
}
