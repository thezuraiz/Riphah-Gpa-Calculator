import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riphah_cgpa_calculator/Pages/Auth%20Pages/login_page.dart';
import 'package:riphah_cgpa_calculator/Pages/Student%20Panel/landingPage.dart';

class CheckRiphah extends StatelessWidget {
  const CheckRiphah({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return LandingPage();
          }else{
            return LoginPage();
          }
        },
      ),
    );
  }
}
