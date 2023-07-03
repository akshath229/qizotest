import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'newuser.dart';

class Loginorregister extends StatefulWidget {
  const Loginorregister({super.key});

  @override
  State<Loginorregister> createState() => _LoginorregisterState();
}

class _LoginorregisterState extends State<Loginorregister> {
  bool showloginpage = true;



  void togglePages(){
    setState(() {
      showloginpage = !showloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showloginpage){
      return LoginPage(onTap: togglePages);

    }else{
      return Addnewuser(onTap: togglePages);
    }
  }
}