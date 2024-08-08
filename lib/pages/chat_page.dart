// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../models/message.dart';
import '../widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  static String id = 'ChatPage';

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isLoading = false;
  bool _showScrollToBottomButton = false;
  late final ScrollController _scrollController;
  late final TextEditingController _messageController;

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  @override
  void initState() {
    _scrollController = ScrollController();
    _messageController = TextEditingController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
              // print("message  ${messagesList[i].message}");
            }

            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/chat_logo.png',
                      height: 28,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'LOKLOK',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kTextColor),
                    ),
                  ],
                ),
              ),
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].userId == email
                              ? ChatBuble(
                                  message: messagesList[index],
                                )
                              : ChatBubleForAfriend(
                                  message: messagesList[index]);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Visibility(
                        visible: _showScrollToBottomButton,
                        child: Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: FloatingActionButton.small(
                            backgroundColor: kPrimaryColor,
                            onPressed: scrollToBottom,
                            child: const Icon(Icons.arrow_downward,color: kHintTextColor,),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        style: const TextStyle(color: kTextColor),
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your message here',
                          hintStyle: const TextStyle(color: kHintTextColor),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.send,
                              color: kIconColor,
                            ),
                            onPressed: () {
                              if (_messageController.text.trim().isNotEmpty) {
                                // Check if the message is not empty
                                messages.add({
                                  kMessage: _messageController.text,
                                  kCreatedAt: DateTime.now()
                                      .toUtc()
                                      .millisecondsSinceEpoch,
                                  kId: email
                                });
                                _messageController.clear();
                                scrollToBottom;
                              }
                            },
                          ),
                          fillColor: Colors.grey[800],
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const ModalProgressHUD(
                inAsyncCall: true,
                child: Scaffold(
                  body: Text(
                    'Loading....',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  backgroundColor: kPrimaryColor,
                ));
          }
        });
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _showScrollToBottomButton = true;
      });
    } else if (_scrollController.position.pixels == 0) {
      setState(() {
        _showScrollToBottomButton = false;
      });
    }
  }
}
