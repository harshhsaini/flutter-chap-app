import 'package:flutter/material.dart';
import '../pages/appsettings.dart';
import '../services/auth/auth_services.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

    void logout(){
// auth service instance
  final auth = AuthServices();
  auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //logo
              DrawerHeader(child: Center(
                child: Icon(Icons.message_rounded,
                  color:  Theme.of(context).colorScheme.primary,
                  size: 50,
                ),
              ),
              ),
              //home list tile
              Padding(padding: EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text('H O M E', ),
                  leading: Icon(Icons.home),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text('S ET T I N G S', ),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);
                    //to settings page
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
                  },
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(left: 25.0, bottom: 25.0),
          child: ListTile(
            title: const Text('L O G O U T', ),
            leading: Icon(Icons.logout),
            onTap: logout,
          ),
          ),
        ],
      ),
    );
  }
}
