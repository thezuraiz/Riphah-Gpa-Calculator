import 'package:flutter/material.dart';
import 'package:riphah_cgpa_calculator/Pages/Admin%20Panel/adminLandingPage.dart';
import 'package:riphah_cgpa_calculator/Pages/Auth%20Pages/login_page.dart';
import 'package:riphah_cgpa_calculator/Pages/Auth%20Pages/siginup_page.dart';
import 'package:riphah_cgpa_calculator/Pages/Auth%20Pages/splash_screen.dart';
import 'package:riphah_cgpa_calculator/Pages/Student%20Panel/Todo/todomain.dart';
import 'package:riphah_cgpa_calculator/Pages/Student%20Panel/cgpaPage.dart';
import 'package:riphah_cgpa_calculator/Pages/Student%20Panel/checkConnectionRiphah.dart';
import 'package:riphah_cgpa_calculator/Pages/Student%20Panel/gpaPage.dart';
import 'package:riphah_cgpa_calculator/Pages/Student%20Panel/landingPage.dart';
import 'package:riphah_cgpa_calculator/Pages/Student%20Panel/riphahWorld.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/connectionError.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/theme.dart';
import 'package:riphah_cgpa_calculator/firebase_options.dart';
import 'package:riphah_cgpa_calculator/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: UiThemeData(),
      initialRoute: Routes.loginPage,
      routes: {
        Routes.splashScreen: (context) => const SplashScreen(),
        Routes.loginPage: (context) => LoginPage(),
        Routes.signupPage: (context) => const SignUpPage(),
        // Landing Page Routes
        Routes.landingPage: (context) => const LandingPage(),
        Routes.checkConnection: (context) => const CheckRiphah(),
        Routes.riphahWorld: (context) => const RiphahWorld(),
        Routes.gpa: (context) => const GPAScreen(),
        Routes.cgpa: (context) => const CGPAPage(),
        Routes.checkError: (context) => const ConnectionError(),

        // Todo Module
        Routes.todomainpage: (context) => TodoMainPage(),

        // Admin Panel
        Routes.adminlandingpage: (context) => AdminLandingPage()
      },
    );
  }
}
