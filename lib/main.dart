import 'package:flutter/material.dart';
import 'package:riphah_cgpa_calculator/Pages/Auth%20Pages/login_page.dart';
import 'package:riphah_cgpa_calculator/Pages/Auth%20Pages/siginup_page.dart';
import 'package:riphah_cgpa_calculator/Pages/Auth%20Pages/splash_screen.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';
import 'package:riphah_cgpa_calculator/firebase_options.dart';
import 'package:riphah_cgpa_calculator/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main()async{
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
      theme: ThemeData(
        primaryColor: Color(Color_helper.button_color),
        useMaterial3: true,
          fontFamily: GoogleFonts.poppins().fontFamily,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(Color_helper.button_color),
            ),
          ),
          prefixIconColor: Color(Color_helper.button_color),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(Color_helper.button_color),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            padding: const EdgeInsets.all(18),
          )
        ),
      ),
      initialRoute: Routes.signupPage,
      routes: {
        Routes.splashScreen: (context) => const SplashScreen(),
        Routes.loginPage: (context) => const LoginPage(),
        Routes.signupPage: (context) => const SignUpPage(),
      },
    );
  }
}
