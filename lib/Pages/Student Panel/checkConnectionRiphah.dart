import 'package:Riphah_CGPA_Calculator/Pages/Auth%20Pages/login_page.dart';
import 'package:Riphah_CGPA_Calculator/Pages/Student%20Panel/landingPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckRiphah extends StatelessWidget {
  const CheckRiphah({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return const LandingPage();
          }else{
            return LoginPage();
          }
        },
      ),
    );
  }
}
