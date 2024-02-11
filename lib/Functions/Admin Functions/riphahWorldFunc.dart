import 'package:flutter/material.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

deleteTeacher(BuildContext context, final id) async {
  try {
    await FirebaseFirestore.instance
        .collection("riphahFaculty")
        .doc(id)
        .delete();

    final QuerySnapshot deleteCollection = await FirebaseFirestore.instance
        .collection("riphahFaculty")
        .doc(id)
        .collection('expertise')
        .get();

    for (QueryDocumentSnapshot doc in deleteCollection.docs) {
      await doc.reference.delete();
    }

    WidgetHelper.custom_message_toast(context, "Deleted");
  } catch (e) {
    WidgetHelper.custom_error_toast(context, "Something Wents Wrong");
  }
}
