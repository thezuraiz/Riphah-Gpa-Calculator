import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

deleteAdmin(BuildContext context, String id) async {
  Navigator.pop(context);
  final String Uid = FirebaseAuth.instance.currentUser!.uid;
  if (Uid == id) {
    WidgetHelper.custom_error_toast(context, "You are deleting you self!");
    return;
  }
  try {
    await FirebaseFirestore.instance
        .collection("adminTeachers")
        .doc(id)
        .delete()
        .then((value) {
      WidgetHelper.custom_message_toast(context, "User Deleted");
    });
  } catch (e) {
    WidgetHelper.custom_error_toast(context, "Something Went Wrong");
  }
}
