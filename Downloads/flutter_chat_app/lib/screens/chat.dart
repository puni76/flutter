import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/chat_messages.dart';
import 'package:flutter_chat_app/widgets/new_messages.dart';
import 'package:flutter_chat_app/widgets/user_image_picker.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications () async{
    final fcm = FirebaseMessaging.instance;
   await fcm.requestPermission();
   fcm.getToken();
    final token = await fcm.getToken();
    if (kDebugMode) {
      print(token);
    }//can send token via http or firestore sdk to backend
    fcm.subscribeToTopic('chat');
  }
  @override
  void initState() {
    super.initState();
    setupPushNotifications();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Chat'
        ),
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          },
              icon:  Icon(Icons.exit_to_app,
        color: Theme.of(context).colorScheme.primary,
      )
      )
        ],
      ),
      body: const Column(
        children: [
          Expanded(child: ChatMessages()),
          NewMessages(),
        ],
      )
    );
  }
}
