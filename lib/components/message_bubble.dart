import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  ChatBubble({super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser
            ? (isDarkMode ? Colors.purple.shade600 : Colors.purple.shade200)
            : (isDarkMode
                ? Colors.purpleAccent.shade700
                : Colors.purpleAccent.shade200),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      child: Text(
        message,
        style: TextStyle(
            color:  isCurrentUser? Colors.white :
            (isDarkMode ? Colors.white : Colors.black)),
      ),
    );
  }
}
