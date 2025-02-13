import 'package:flutter/material.dart';
import 'package:chat_app/components/myButton.dart';
import 'package:chat_app/components/my_textfield.dart';

import '../services/auth/auth_services.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginPage({
    super.key,
    required this.onTap,
  });
  final void Function()? onTap;
  //login method
  void login(BuildContext context) async {
  //auth services
  final authService = AuthServices();
  //try login
    try{
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
    }
    catch (e){
      showDialog(context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(
                height: 30,
              ),
              //welcome back
              Text(
                "Welcome back, you've been missed!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              //email Text
              MyTextField(
                obscureText: false,
                controller: _emailController,
                hintText: "Email...",
              ),
              SizedBox(
                height: 10,
              ),
              //pw Text
              MyTextField(
                controller: _passwordController,
                obscureText: true,
                hintText: "Password...",
              ),
              SizedBox(
                height: 25,
              ),
              //login button
              MyButton(
                onTap: () => login(context),
                text: "Login",
              ),
              SizedBox(
                height: 15,
              ),
              //register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      'Register now!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
