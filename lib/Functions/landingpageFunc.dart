import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


// SignOut Button Function
signoutButton(context){
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Are You Sure to Log Out"),
        actions: [
          TextButton(
            onPressed: () {
              signOut(context);
            },
            child: const Text(
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
            child: const Text(
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
      debugPrint("User Signout");
    });
  } on FirebaseException catch (e) {
    debugPrint("Error: ${e.code.toString()}");
  }
}