import 'package:flutter/material.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';
import 'package:riphah_cgpa_calculator/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(Color_helper.background_color),
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                WidgetHelper.customSizedBox(30),
                Image.asset(
                  "lib/Assets/Images/Riphah_Logo.png",
                  scale: 3.6,
                ),
                WidgetHelper.customSizedBox(55),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "example@riphah.edu.pk",
                      prefixIcon: Icon(Icons.email_outlined)),
                ),
                WidgetHelper.customSizedBox(20),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Password", prefixIcon: Icon(Icons.password)),
                ),
                WidgetHelper.customSizedBox(20),
                SizedBox(
                  width: double.infinity,
                  // height: 60,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Log In")),
                ),
                WidgetHelper.customSizedBox(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(Color_helper
                            .button_color), // Optionally, specify the color
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "OR",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(Color_helper
                            .button_color), // Optionally, specify the color
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.popAndPushNamed(context, Routes.signupPage),
                  child: const Text(
                    "Create Account?  SignUp!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
