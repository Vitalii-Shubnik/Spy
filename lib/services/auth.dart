import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> onUserChanged(){
    return _auth.authStateChanges()
    .map((User? user) => user);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential? result = await _auth.signInAnonymously();
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmail(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
      final User user = result.user!;
      return user;
    } catch(e){
      print(e.toString());
      return null;
    }

  }
  //register with email and password
  Future registerWithEmail(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
      final User user = result.user!;
      return user;
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}
