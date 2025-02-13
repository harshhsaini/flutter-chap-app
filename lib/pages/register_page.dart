import 'package:flutter/material.dart';
import '../components/myButton.dart';
import '../components/my_textfield.dart';
import '../services/auth/auth_services.dart';
class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
   RegisterPage({super.key, required this.onTap});
  final void  Function()? onTap;
void register(BuildContext context){
// auth services instances
   final _auth = AuthServices();
   //when password matches
   if(_passwordController.text == _confirmPasswordController.text ) {
     try {
       _auth.signUpWithEmailPassword(
           _emailController.text,
           _passwordController.text);
     }
     catch(e) {
       showDialog(context: context,
           builder: (context) => AlertDialog(
             title:  Text(e.toString()),
           ));
     }
   }
   //password not matched
   else {
     showDialog(context: context,
         builder: (context) => const AlertDialog(
           title:  Text('Password not matched!'),
         ));
   }
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(Icons.message,
                size: 70,
                color: Theme.of(context).colorScheme.primary,),
              SizedBox( height: 30,),
              //welcome back
              Text("Let's create an account for you!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              SizedBox( height: 15,),
              //email Text
              MyTextField(
                obscureText: false,
                controller: _emailController,
                hintText: "Email...",
              ),
              SizedBox( height: 15,),
              //pw Text
              MyTextField(
                controller: _passwordController,
                obscureText: true,
                hintText: "Password...",
              ),
              SizedBox( height: 10,),
              //cpw Text
              MyTextField(
                controller: _confirmPasswordController,
                obscureText: true,
                hintText: "Confirm Password...",
              ),
              SizedBox( height: 25,),
              //login button
              MyButton(
                onTap: () => register(context),
                text: "Register Now!",
              ),
              SizedBox( height: 15,),
              //register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child:
                      Text('Login here!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
