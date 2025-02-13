
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/components/message_bubble.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:chat_app/services/chat/chat_services.dart';
class ChatPage extends StatelessWidget {
  final String receiveEmail;
  final String receiveID;

   ChatPage({super.key,
  required this.receiveEmail,
  required this.receiveID
  });
final TextEditingController _messageController = TextEditingController();

 //auth and chat services
  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();
  // send messages
  void sendMessage() async {
  if(_messageController.text.isNotEmpty){
    try {
      //print("Attempting to send message: ${_messageController.text}");
      //print("Receiver ID: $receiveID");
      await _chatServices.sendMessage(receiveID, _messageController.text);
      //print("Message sent successfully");
      _messageController.clear();
    } catch (e) {
      //print("Error sending message: $e");
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar:  AppBar(
        title: Text(receiveEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(),
          ),
          //user input
          _buildUserInput()
        ],
      ),
    );
  }
  Widget _buildMessageList() {
  String senderID = _authServices.getCurrentUser()!.uid;
  return StreamBuilder(
    stream: _chatServices.getMessages(receiveID, senderID),
    builder: (context, snapshot) {
     // print("Connection state: ${snapshot.connectionState}");
     // print("Has data: ${snapshot.hasData}");
      if (snapshot.hasData) {
        //print("Number of messages: ${snapshot.data!.docs.length}");
      }
      
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      
      if (snapshot.hasError) {
        //print("Stream error: ${snapshot.error}");
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return const Center(child: Text('No messages yet'));
      }

      return ListView.builder(
        reverse: true,
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          return _buildMessageItem(snapshot.data!.docs[index]);
        },
      );
    }
  );
}
  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

  // current user
  bool isCurrentUser = data['senderID'] == _authServices.getCurrentUser()!.uid;
  
  return Container(
    alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChatBubble(
        message: data["message"],
        isCurrentUser: isCurrentUser,
      ),
    ),
  );
}
  //build message input
    Widget _buildUserInput(){
    return Padding(padding: EdgeInsets.only(bottom: 50),
    child: Row(
      children: [
        //textfield should take up most of the space
        Expanded(child:
        MyTextField(
          controller: _messageController,
          hintText: "Type message here!",
          obscureText: false,
        )
        ),
        //send button
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF00BCD4),
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.only(right: 25) ,
          child: IconButton(onPressed: sendMessage,
              icon: Icon(Icons.arrow_upward,
              color: Colors.white,
              )),
        ),
      ],
    ),
    );
    }
}
