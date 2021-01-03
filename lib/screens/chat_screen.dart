//import 'dart:html';

import 'package:HeyThere/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:HeyThere/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgTextController = TextEditingController();
  // final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String msgText;
  //User loggedInUser;
  //The FirebaseUser class has been (breaking)renamed to User.

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  //to get the details of the current user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      //Accessing the current user via currentUser() is now synchronous via the currentUser getter.

      if (user != null) {
        loggedInUser = user;
        //print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var msg in messages.docs) {
  //     print(msg.data());
  //   }
  // }

  void msgStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //getMessages();
                msgStream();

                //Implement logout functionality
                _auth.signOut();
                Navigator.pushNamed(context, RegistrationScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MsgStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        msgText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      msgTextController.clear();
                      //Implement send functionality.
                      //We have msgText + loogedInUSer
                      _firestore.collection('messages').add({
                        //add fn expexts a map(ket,value pairs) where key is our field in the document
                        'sender': loggedInUser.email,
                        'text': msgText,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MsgStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.teal,
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        List<Widget> messageWidgets = [];
        for (var message in messages) {
          final currentUserID = loggedInUser.email;
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];

          final messageBubble = MsgBubble(
              sender: messageSender,
              text: messageText,
              // alternative of if statement
              isCurrentUser: currentUserID == messageSender);
          messageWidgets.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse:true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MsgBubble extends StatelessWidget {
  MsgBubble({this.sender, this.text, this.isCurrentUser});
  final String sender;
  final String text;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
          Material(
            //Changing the shape of the text box accroding to the user
            borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isCurrentUser?30:0),
                    topRight: Radius.circular(isCurrentUser?30:0),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
               
            //changing colour for different users
            color: isCurrentUser ? Colors.blueAccent[100] : Colors.teal,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                // '$Text from $sender',
                text,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
