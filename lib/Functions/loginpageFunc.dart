import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

Future<String> AdminLoginPanel(
    GlobalKey<FormState> formKey, String email, String password) async {
  debugPrint("object-> $email");
  debugPrint("object-> $password");
  // try {
  //   await FirebaseAuth.instance.signOut();
  // } catch (e) {
  //   debugPrint("Error signing out: $e");
  // }


   final Auth =  await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) async {

      final userId = FirebaseAuth.instance.currentUser?.uid;

      final docSnapshot = await FirebaseFirestore.instance
          .collection("adminTeachers")
          .doc(userId)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        debugPrint("User Email: ${data!['adminEmail']}");
        debugPrint("User Password: ${data!['adminPass']}");

        final firestoreEmail = data!['adminEmail'];
        final bytes = utf8.encode(password);
        final hashPassword = sha256.convert(bytes).toString();

        if (firestoreEmail == email && data['adminPass'] == hashPassword) {
          debugPrint("Credentials Matched");
          debugPrint('Authorized');
          return 'true';
        }
      } else {
        debugPrint("Document does not exist");
        // Handle unauthorized user
        return 'null';
      }
    });
   if(Auth != null){
     return 'true';
   }
    return 'null';
  // debugPrint("Context after Singin: $context");
}
