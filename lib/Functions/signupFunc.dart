import 'package:Riphah_CGPA_Calculator/Ui%20Helper/widget_helper.dart';
import 'package:Riphah_CGPA_Calculator/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

// To Signup data on sign up form

signUp(BuildContext context, final String name, final String sap,
    final String email, String password) async {
  if (email.isEmpty || password.isEmpty) return;

  debugPrint("email $email");
  debugPrint("pass: $password");
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      try {
        uploadData(context, name, email, sap);
      } catch (e) {
        WidgetHelper.custom_error_toast(context, e.toString());
      }
      Navigator.popAndPushNamed(context, Routes.checkConnection);
    });
  } on FirebaseAuthException catch (ex) {
    WidgetHelper.custom_error_toast(context, ex.message.toString());
  } catch (ex) {
    WidgetHelper.custom_error_toast(context, ex.toString());
  }
}

// To upload data on sign up form
uploadData(BuildContext context, final String name, final String email,
    final String sap) async{
  try {
    String studentID = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("Students").doc(studentID).set({
      "name": name,
      "email": email,
      "sap": sap,
      "gpa": "",
      "last_cgpa": "",
      "total_subjects": ""
    });
    await WidgetHelper.custom_message_toast(context, "Account Created");
    await Navigator.popAndPushNamed(context, Routes.checkConnection);


  } catch (e) {
    debugPrint('Error on uploadData: ${e.toString()}');
  }
}

// For Google Authentication

Future<UserCredential?> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;
    if (googleAuth == null) {
      throw FirebaseAuthException(
        code: 'google-auth-error',
        message: 'Failed to authenticate via Google.',
      );
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final profile = userCredential.additionalUserInfo?.profile;
    if (profile == null) {
      throw FirebaseAuthException(
        code: 'profile-error',
        message: 'Failed to retrieve user profile.',
      );
    }

    final givenName = profile['given_name'];
    final familyName = profile['family_name'];
    final pictureUrl = profile['picture'];
    final email = profile['email'];

    final studentId = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection("Students").doc(studentId);
    final userData = await userRef.get();

    if (!userData.exists) {
      await userRef.set({
        "name": "$givenName $familyName",
        "email": email,
        "profile_picture": pictureUrl
      });
    }

    Navigator.popAndPushNamed(context, Routes.checkConnection);

    return userCredential;
  } catch (e) {
    debugPrint("Error: ${e.toString()}");
    WidgetHelper.custom_error_toast(context, 'Something Went Wrong!');
    return null;
  }
}