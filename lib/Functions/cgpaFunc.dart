import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

calculateGPA(
    final String pCH, final String pGPA, final String nCHR, final String nGPA) {
  // print("pCH: $pCH");
  // print("pGPA: $pGPA");
  // print("nCHR: $nCHR");
  // print("nGPA: $nGPA");

  double Previous_Credit_Hrs = double.parse(pCH);
  double Previous_GPA = double.parse(pGPA);
  double New_Credit_Hrs = double.parse(nCHR);
  double New_SGPA = double.parse(nGPA);

  double CGPA =
      ((Previous_Credit_Hrs * Previous_GPA) + (New_Credit_Hrs * New_SGPA)) /
          (Previous_Credit_Hrs + New_Credit_Hrs);
  try {
    String studentId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("Students").doc(studentId).update({
      "last_cgpa": CGPA.toString(),
      "total_subjects": Previous_Credit_Hrs + New_Credit_Hrs
    });
  } catch (e) {
    debugPrint('Error on CalculateGPA: ${e.toString()}');
  }

  return CGPA;
}

showMessage(double cgpa) {
  if (cgpa > 1 && cgpa < 2) {
    return "Probation";
  } else if (cgpa > 2 && cgpa < 2.5) {
    return "Need Hard Work";
  } else if (cgpa >= 2.5 && cgpa < 3) {
    return "Average";
  } else if (cgpa >= 3 && cgpa < 4) {
    return "Excellent";
  } else {
    return "";
  }
}
