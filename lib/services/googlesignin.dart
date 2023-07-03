import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  signinwithgoogle() async {
    //signin box
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //auth details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //new user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //final sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}