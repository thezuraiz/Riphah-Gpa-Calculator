import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Ui Helper/widget_helper.dart';
import '../routes.dart';

StudentLoginPage(BuildContext context, final formKey, final String email,
    final String password) async {
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

AdminLoginPanel(BuildContext context, GlobalKey<FormState> formKey,
    String email, String password) async {
  debugPrint("object-> $email");
  debugPrint("object-> $password");
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    debugPrint("Error signing out: $e");
  }

  try {
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Ensure user is signed in before accessing currentUser
    if (userCredential.user != null) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final docSnapshot = await FirebaseFirestore.instance
          .collection("adminTeachers")
          .doc(userId)
          .get();
      if (docSnapshot.exists) {
        // Access the data inside the document
        final data = docSnapshot.data();

        // debugPrint the entire data
        debugPrint("Data inside the document: $data");
        debugPrint("User Password: ${data!['adminEmail']}");
        debugPrint("User Password: ${data!['adminPass']}");
        final firestoreEmail = data!['adminEmail'];
        final firestorePassword = data!['adminPass'];
        if (firestoreEmail == email && firestorePassword == password) {
          Navigator.pushNamed(context, Routes.adminlandingpage);
          debugPrint('Authorized');
        } else {
          WidgetHelper.custom_error_toast(context, "Invalid Credentials");
        }
      } else {
        debugPrint("Document does not exist");
        WidgetHelper.custom_error_toast(context, "Unauthorized User");
      }
    }
  } on FirebaseAuthException catch (e) {
    WidgetHelper.custom_error_toast(context, e.code);
    debugPrint("FirebaseAuthException: ${e.code.toString()}");
  } catch (e) {
    debugPrint("Error: $e");
    WidgetHelper.custom_error_toast(context, "An error occurred");
  }
}
