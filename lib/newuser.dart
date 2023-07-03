import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Addnewuser extends StatefulWidget {
  final Function()? onTap;
  const Addnewuser({super.key,required this.onTap});

  @override
  State<Addnewuser> createState() => _AddnewuserState();
}

class _AddnewuserState extends State<Addnewuser> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final ageController = TextEditingController();


   @override
   void dispose(){
     emailController.dispose();
     passwordController.dispose();
     confirmpasswordController.dispose();
     firstnameController.dispose();
     lastnameController.dispose();
     ageController.dispose();
     super.dispose();
   }

  Future<void> NewsignUserIn() async {
     
     if(passwordConfirmed()){
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
           email: emailController.text.trim(), password: passwordController.text.trim()
       );
       
       //user details
       adduserdetails(firstnameController.text.trim(), 
           lastnameController.text.trim(), 
           emailController.text.trim(),
           int.parse(ageController.text.trim()),
       );

       
       
     }
     
  }
  Future adduserdetails(String firstname, String lastname, String email,int age) async{
    await FirebaseFirestore.instance.collection("users").add({
      "first name":firstname,
      "last name": lastname,
      "age": age ,
      "email": email,
    });
  }
  bool passwordConfirmed(){
    if(passwordController.text.trim() ==  confirmpasswordController.text.trim()
    ){
      return true;
    }else{
      return false;
    }
  }


  void wrongemail(){
    showDialog(context: context, builder: (context)
    {
      return AlertDialog(title: Text("wromg email"),);
    },);
  }
  void reallywrongpassword(){
    showDialog(context: context, builder: (context)
    {
      return AlertDialog(title: Text("wromg password"),);
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
                const SizedBox(height: 25),


                const Icon(
                  Icons.info_outlined,
                  size: 50,
                ),

                const SizedBox(height: 20),


                Text(
                  'Create new\'account',
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
                    controller: firstnameController,
                    decoration: InputDecoration(hintText: 'Firstname'),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 10),


                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: lastnameController,
                    decoration: InputDecoration(hintText: 'Lastname'),
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 10),


                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: ageController,
                    decoration: InputDecoration(hintText: 'Age'),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 10),


                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(hintText: 'Password'),
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 10),


                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: confirmpasswordController,
                    decoration: InputDecoration(hintText: 'confirmpassword'),
                    obscureText: true,
                  ),
                ),


                const SizedBox(height: 25),


                ElevatedButton(onPressed:  NewsignUserIn, child: Text("Register")),


                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(onTap:widget.onTap,
                      child: Text(
                        'Login now',
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