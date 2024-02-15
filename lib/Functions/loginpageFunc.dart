import 'dart:convert';
import 'package:Riphah_CGPA_Calculator/Pages/Admin%20Panel/adminLandingPage.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Ui Helper/widget_helper.dart';
import '../routes.dart';

StudentLoginPage(BuildContext context, final formKey, final String email,
    final String password) async {
  FocusManager.instance.primaryFocus!.unfocus();

  if (formKey.currentState!.validate()) {
    FocusManager.instance.primaryFocus!.unfocus();

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              Navigator.popAndPushNamed(context, Routes.checkConnection));
    } on FirebaseAuthException catch (e) {
      WidgetHelper.custom_error_toast(context, e.code.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

AdminLoginPanel(context, GlobalKey<FormState> formKey, String email,
    String password) async {
  debugPrint("object-> $email");
  debugPrint("object-> $password");

  try {
    debugPrint("Context after Singin: $context");

    final bytes = await utf8.encode(email);
    final uniqueId = await sha256.convert(bytes).toString();
    debugPrint("UniqueId: $uniqueId");

    final docSnapshot = await FirebaseFirestore.instance
        .collection("adminTeachers")
        .doc(uniqueId)
        .get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      debugPrint("Context: $context");
      debugPrint("Data inside the document: $data");
      debugPrint("User Email: ${data!['adminEmail']}");
      debugPrint("User Password: ${data!['adminPass']}");

      final firestoreEmail = data!['adminEmail'];
      final firestorePassword = data!['adminPass'];

      final bytes = await utf8.encode(password);
      final hashPassword = await sha256.convert(bytes).toString();
      debugPrint("Digest as hex string: $hashPassword");

      if (firestoreEmail == email && firestorePassword == hashPassword) {
        debugPrint("Credentials Matched");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminLandingPage(email: email)));
        WidgetHelper.custom_message_toast(context, "Authorized");
      } else {
        debugPrint("Context: $context");
        WidgetHelper.custom_error_toast(context, "Invalid Credentials");
        await FirebaseAuth.instance.signOut();
      }
    } else {
      debugPrint("Document does not exist");
      WidgetHelper.custom_error_toast(context, "Unauthorized User");
      await FirebaseAuth.instance.signOut();
    }
  } catch (e) {
    debugPrint("Error: $e");
    WidgetHelper.custom_error_toast(context, "An error occurred: Try again!");
  }
}
