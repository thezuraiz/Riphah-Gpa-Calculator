import 'package:flutter/material.dart';
import 'package:riphah_cgpa_calculator/Functions/Admin%20Functions/addadminFunc.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddAdminPage extends StatelessWidget {
  const AddAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    // final String referenceAdmin = FirebaseAuth.instance.currentUser!.uid;
    final String referenceAdmin = 'FirebaseAuth.instance.currentUser!.uid';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Admin Panel"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              WidgetHelper.customSizedBox(50),
              Image.asset(
                "lib/Assets/Images/Riphah_Logo.png",
                height: 380,
              ),
              WidgetHelper.customSizedBox(40),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Enter Email",
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
              WidgetHelper.customSizedBox(10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Enter Password",
                ),
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              WidgetHelper.customSizedBox(10),
              ElevatedButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus!.unfocus();
                  if (_formKey.currentState!.validate()) {
                      AddAdmin(context, emailController.text.toString(), passwordController.text.toString(), referenceAdmin);
                  }
                },
                child: const Text("Add Admin"),
              ),
              WidgetHelper.customSizedBox(40),
            ],
          ),
        ),
      ),
    );
  }
}
