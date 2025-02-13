import 'package:flutter/material.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:chat_app/services/chat/chat_services.dart';
// import 'package:minimalchatapp/auth/auth_services.dart';

import '../components/my_drawer.dart';
import '../components/usertile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

//   void logout(){
// // auth service instance
//   final _auth = AuthServices();
//   _auth.signOut();
//   }
  // chat and auth services
  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Home'),
        ),
        backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
        elevation: 0,
        // actions: [
        //   IconButton(onPressed: logout,
        //       icon: Icon(Icons.logout))
        // ],
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  //build user list
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatServices.getUsersStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("Error");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  //build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user
    if (userData["email"] !=
        _authServices.getCurrentUser()!.email) {
      return UserTile(
        onTap: () {
          //tapped on a user => go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiveEmail: userData["email"],
                  receiveID: userData["uid"],

                ),
              ));
        },
        text: userData["email"],
      );
    } else {
      return Container();
    }
  }
}
