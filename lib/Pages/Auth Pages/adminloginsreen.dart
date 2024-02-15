import 'package:Riphah_CGPA_Calculator/Functions/loginpageFunc.dart';
import 'package:Riphah_CGPA_Calculator/Ui%20Helper/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AdminLoginSreen extends StatelessWidget {
  const AdminLoginSreen({super.key});

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
                Image.asset(
                  "lib/Assets/Images/Riphah_Logo.png",
                  scale: 3.6,
                ),
                WidgetHelper.customSizedBox(55),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'example@riphah.edu.pk',
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    } else if (!value.endsWith("@riphah.edu.pk")) {
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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          final email = emailController.text.toString();
                          final password = passwordController.text.toString();
                          AdminLoginPanel(context, formKey, email, password);
                        }
                      },
                      child: const Text("Log In")),
                ),
                WidgetHelper.customSizedBox(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
