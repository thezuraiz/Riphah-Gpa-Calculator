import 'package:flutter/material.dart';
import 'package:riphah_cgpa_calculator/Functions/loginpageFunc.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';
import 'package:riphah_cgpa_calculator/routes.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int adminTap = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint('Main Context: ${context}');
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      // backgroundColor: Color(Color_helper.background_color),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                     WidgetHelper.customSizedBox(30),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (adminTap <= 10) {
                      adminTap++;
                    }

                    if (adminTap == 10) {
                      setState(() {
                        debugPrint("Admin panel true");
                        Navigator.popAndPushNamed(context, Routes.adminloginsreen);
                        WidgetHelper.custom_message_toast(context, "You are now admin console");
                        adminTap = 0;
                      });
                    }
                    if (adminTap > 5 && adminTap <= 10) {
                      WidgetHelper.custom_message_toast(context,
                          "Click Left ${10 - adminTap} for Admin Panel");
                    }
                  },
                  child: Image.asset(
                    "lib/Assets/Images/Riphah_Logo.png",
                    scale: 3.6,
                  ),
                ),
                WidgetHelper.customSizedBox(55),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'example@students.riphah.edu.pk',
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      } else if (!value.endsWith( "@students.riphah.edu.pk")) {
                        return "Only Riphah Email Required";
                      } else if (!value.contains('@')) {
                        return "Invalid Email";
                      } else {
                        return null; // Return null if validation passes
                      }
                  },
                ),
                WidgetHelper.customSizedBox(20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.password),
                  ),
                  controller: passwordController,
                  validator: RequiredValidator(errorText: "Required"),
                ),
                WidgetHelper.customSizedBox(20),
                SizedBox(
                  width: double.infinity,
                  // height: 60,
                  child: ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          final email = emailController.text.toString();
                          final password = passwordController.text.toString();
                          StudentLoginPage(context,formKey, email, password);
                        }
                      },
                      child: const Text("Log In")),
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
