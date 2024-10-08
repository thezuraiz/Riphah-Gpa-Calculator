import 'package:Riphah_CGPA_Calculator/Ui%20Helper/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

deleteTeacher(BuildContext context, final id) async {
  debugPrint("pressed: pressed");
  Navigator.pop(context);
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
