import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

  // get current user
  User? getCurrentUser(){
    return _auth.currentUser;
  }
  //instance of auth
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign in
Future<UserCredential> signInWithEmailPassword(String email, password) async {
  try{
    UserCredential userCredential = await _auth.signInWithEmailAndPassword
      (email: email, password: password);
    //save user data in separate file if not exist
    _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        }
    );
    return userCredential;
  }
      on FirebaseAuthException catch(e) {
    throw Exception(e.code);
  }
}
  //sign up
Future<UserCredential> signUpWithEmailPassword(String email, password) async{
  //create user
  try{
UserCredential userCredential =
    await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password);
//save user data in separate file
    _firestore.collection("Users").doc(userCredential.user!.uid).set(
      {
    'uid': userCredential.user!.uid,
        'email': email,
      }
    );

return userCredential;
  } on FirebaseAuthException catch(e) {
  throw Exception(e.code);
      }
}
  //sign out
Future<void> signOut() async {
  return await _auth.signOut();
}
  //errors

}