import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riphah_cgpa_calculator/routes.dart';


// SignOut Button Function
signoutButton(context){
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Are You Sure to Log Out"),
        actions: [
          TextButton(
            onPressed: () {
              signOut(context);
            },
            child: Text(
              "Yes",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "No",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    },
  );
}

signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut().then((value) async {
      Navigator.pop(context);
      print("User Signout");
    });
  } on FirebaseException catch (e) {
    print("Error: ${e.code.toString()}");
  }
}