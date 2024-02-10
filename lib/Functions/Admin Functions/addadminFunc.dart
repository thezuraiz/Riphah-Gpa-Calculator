import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';

AddAdmin(BuildContext context,String email,String password,String referenceAdmin)async{
    try{
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null){
        await FirebaseFirestore.instance.collection('adminTeachers').doc(userCredential.user!.uid).set(
            {
              "adminEmail": email,
              "adminPass": password,
              "referenceAdmin": referenceAdmin,
              "timeStamp": DateTime.timestamp()
            }
        );
        WidgetHelper.custom_message_toast(context, "Admin Added");
      }
    }on FirebaseAuthException catch(e){
      WidgetHelper.custom_error_toast(context, e.code.toString());
    }
}