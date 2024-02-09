import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';
import 'package:riphah_cgpa_calculator/routes.dart';

signUp(BuildContext context,final String name,final String sap,final String email, String password) async {
  if (email.isEmpty || password.isEmpty) return;
  print("email $email");
  print("pass: $password");
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email,
        password: password)
        .then((value) {
          try{
            uploadData(context,name,email,sap);
          }catch(e){
            WidgetHelper.custom_error_toast(context,e.toString());
          }
    });
  } on FirebaseAuthException catch (ex) {
    WidgetHelper.custom_error_toast(context,ex.message.toString());
  } catch (ex) {
    WidgetHelper.custom_error_toast(context,ex.toString());
  }
}

uploadData(BuildContext context,final String name,final String email,final String sap) async {
  String studentID = FirebaseAuth.instance.currentUser!.uid;
  await FirebaseFirestore.instance
      .collection("Students")
      .doc(studentID)
      .set({
    "name": name,
    "email": email,
    "sap": sap,
    "last_gpa": "",
    "last_cgpa": "",
    "total_subjects": "",
    "profile_picture": ""
  }).then((value) {
    WidgetHelper.custom_message_toast(context, "Account Created");
    Future.delayed(const Duration(seconds: 1));
    Navigator.popAndPushNamed(context, Routes.landingPage);
  });
}
