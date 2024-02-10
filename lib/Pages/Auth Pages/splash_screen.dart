import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';
import 'package:riphah_cgpa_calculator/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    jumpOnNextPage();
  }

  jumpOnNextPage()async{
    await Future.delayed(const Duration(seconds: 1));

    var flag = FirebaseAuth.instance.currentUser;
    if(flag != null){
      Navigator.popAndPushNamed(context, Routes.checkConnection);
    }else{
      Navigator.popAndPushNamed(context, Routes.loginPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Color(Color_helper.background_color),
          ),
        child: Center(
          child: Hero(
            tag: Key("Logo_Animation"),
            child: Image.asset("lib/Assets/Images/Riphah_Logo.png",
              width: 320,
            ),
          ),
        ),
      ),
    );
  }
}
