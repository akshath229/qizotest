import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qizologin/services/googlesignin.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  Future<void> signUserIn() async {

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    }on FirebaseAuthException catch (e) {
      if(e.code == "user-not-found"){
        wrongemail();
      }else if (
      e.code == "wrong-password"
      ){
        reallywrongpassword();
      }
    }
  }
  void wrongemail(){
    showDialog(context: context, builder: (context)
    {
      return AlertDialog(title: Text("wrong email"),);
    },);
  }
  void reallywrongpassword(){
    showDialog(context: context, builder: (context)
    {
      return AlertDialog(title: Text("wrong password"),);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),


                const Icon(
                  Icons.account_circle,
                  size: 100,
                ),

                const SizedBox(height: 50),


                Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),


                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: emailController,decoration: InputDecoration(hintText: 'Email'),
                    obscureText: false,
                  ),
                ),

                const SizedBox(height: 10),


                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(hintText: 'password'),
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 25),

                ElevatedButton(onPressed:  signUserIn, child: Text("sign in")),

                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    // google button
                    GestureDetector(onTap: () => AuthService().signinwithgoogle(),
                      child: Container(height: 50,width: 50,
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("lib/images/google-logo-9827.png"))),

                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have account',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(onTap:widget.onTap,
                      child: Text(
                        'create now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
