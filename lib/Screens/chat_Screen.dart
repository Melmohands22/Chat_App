import 'package:chat_app/constant.dart';
import 'package:chat_app/models/messageModel.dart';
import 'package:chat_app/widgets/chatBabbel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class chatScreen extends StatelessWidget {
  chatScreen({super.key});
  final _controller = ScrollController();
  static String id = 'chatScreen';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(Kmessages);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages
          .orderBy(
            KcratedAt,
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        var email = ModalRoute.of(context)!.settings.arguments;
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: KpraimaryColor,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Klogo,
                        height: 65,
                      ),
                      Text(
                        'my chat',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBubble(
                                message: messagesList[index],
                              )
                            : ChatBubbleForFriend(message: messagesList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          'messages': data,
                          KcratedAt: DateTime.now(),
                          'id': email
                        });
                        controller.clear();
                        _controller.animateTo(0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: KpraimaryColor,
                          ),
                          onPressed: () {},
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: KpraimaryColor)),
                      ),
                    ),
                  )
                ],
              ));
        } else {
          return ModalProgressHUD(
            inAsyncCall: true,
            child: Container(),
          );
        }
      },
    );
  }
}
