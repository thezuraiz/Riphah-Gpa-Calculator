import 'dart:convert';
import 'package:Riphah_CGPA_Calculator/Ui%20Helper/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

AddAdmin(BuildContext context, String email, String password,
    String referenceAdmin) async {
  debugPrint('Email: $email');
  debugPrint('Pass: $password');
  final passBytes = await utf8.encode(password);
  final passwordHash = await sha256.convert(passBytes).toString();

  final emailBytes = await utf8.encode(email);
  final emailHash = await sha256.convert(emailBytes).toString();

  try {
    final String timeStamp = DateTime.timestamp().toString();
    await FirebaseFirestore.instance
        .collection('adminTeachers')
        .doc(emailHash)
        .set({
      "adminEmail": email,
      "adminPass": passwordHash,
      "referenceAdmin": referenceAdmin,
      "timeStamp": timeStamp
    });
    WidgetHelper.custom_message_toast(context, "Admin Added");
    // }
  } catch (e) {
    WidgetHelper.custom_error_toast(context, e.toString());
  }
}

deleteAdmin(BuildContext context, String adminID, String id) async {
  debugPrint('Context: $context');
  debugPrint('adminId: $adminID');
  debugPrint('id: $id');
  final currentloginEmail = await utf8.encode(adminID);
  final hashLoginEmail = await sha256.convert(currentloginEmail).toString();

  if (hashLoginEmail == id) {
    Navigator.pop(context);
    WidgetHelper.custom_error_toast(context, "You are deleting you self!");
    return;
  }
  try {
    await FirebaseFirestore.instance
        .collection("adminTeachers")
        .doc(id)
        .delete();

    debugPrint('User Deleted');
    await WidgetHelper.custom_message_toast(context, "User Deleted");
  } catch (e) {
    WidgetHelper.custom_error_toast(context, "Something Went Wrong");
  }
  Navigator.pop(context);
}
