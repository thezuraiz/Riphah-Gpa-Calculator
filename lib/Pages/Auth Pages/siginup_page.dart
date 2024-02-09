import 'dart:io';
import 'package:flutter/material.dart';
import 'package:riphah_cgpa_calculator/Functions/signupFunc.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';
import 'package:riphah_cgpa_calculator/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController sapIdController = TextEditingController();

  File? pickedImage;
  bool loaderFlag = false;
  bool googleLoaderFlag = false;

  final _formKey = GlobalKey<FormState>();

  MoveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final String name = nameController.text.toString();
      final String email = emailController.text.toString();
      final String password = passController.text.toString();
      final String sap = sapIdController.text.toString();
      await signUp(context, name, sap, email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 60, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    WidgetHelper.customSizedBox(25),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Enter Name:",
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      controller: nameController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Name Required"),
                        MaxLengthValidator(14, errorText: "Maximum Length 14")
                      ]),
                    ),
                    WidgetHelper.customSizedBox(25),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Enter Email:",
                          hintText: "example@riphah.edu.pk",
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Email Required"),
                        EmailValidator(errorText: 'Invalid Email')
                      ]),
                      controller: emailController,
                    ),
                    WidgetHelper.customSizedBox(25),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Sap ID:",
                          prefixIcon: const Icon(Icons.numbers),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Sap Required"),
                        MaxLengthValidator(5, errorText: "Maximum length is 5")
                      ]),
                      controller: sapIdController,
                      keyboardType: TextInputType.number,
                    ),
                    WidgetHelper.customSizedBox(25),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password:",
                        prefixIcon: const Icon(Icons.password_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: passController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Password Required"),
                        MinLengthValidator(6,
                            errorText:
                                "Password Should be greater then 6 Digits"),
                        MaxLengthValidator(16,
                            errorText:
                                "Password Should be less then 16 Digits"),
                      ]),
                    ),
                    WidgetHelper.customSizedBox(25),
                    loaderFlag
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => MoveToHome(context),
                              child: const Text("Register"),
                            ),
                          ),
                    WidgetHelper.customSizedBox(25),
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
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                    WidgetHelper.customSizedBox(14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                          IconButton(
                                onPressed: ()async{
                                  signInWithGoogle().then((value)async{
                                    try{
                                      final profile = value.additionalUserInfo!.profile;
                                      final givenName = profile!['given_name'];
                                      final familyName = profile['family_name'];
                                      final pictureUrl = profile['picture'];
                                      final id = profile['id'];
                                      final email = profile['email'];

                                      await FirebaseFirestore.instance.collection("Students").doc(id).set(
                                          {
                                            "name": "$givenName $familyName",
                                            "email": email,
                                            "sap": "",
                                            "last_gpa": "",
                                            "last_cgpa": "",
                                            "total_subjects": "",
                                            "profile_picture": pictureUrl
                                          });
                                    }catch(err){

                                    }
                                  });
                                  },
                                icon: Image.asset(
                                  "lib/Assets/Icons/Google_Icon.png",
                                  scale: 8,
                                ),
                              ),
                        IconButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, Routes.phoneAuth),
                          icon: Icon(
                            Icons.phone_forwarded,
                            size: 45,
                            color: Color(Color_helper.button_color),
                          ),
                        ),
                      ],
                    ),
                    WidgetHelper.customSizedBox(20),
                    const Text(
                      "Already have an account",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    WidgetHelper.customSizedBox(15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, Routes.loginPage);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Color(Color_helper.button_color),
                            width: 3,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ), // Adjust the radius as needed
                          ),
                        ),
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              color: Color(Color_helper.button_color)),
                        ),
                      ),
                    ),
                    WidgetHelper.customSizedBox(30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
