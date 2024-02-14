import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';

createFunc(
    TextEditingController titleController,
    TextEditingController descController,
    final taskKey,
    BuildContext context) async {
  FocusManager.instance.primaryFocus!.unfocus();
  if (taskKey.currentState!.validate()) {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection("Students")
          .doc(user!.uid)
          .collection("mytasks")
          .doc(DateTime.now().toString())
          .set({
        "title": titleController.text.toString(),
        "description": descController.text.toString()
      }).then((value) {
        Navigator.pop(context);
        WidgetHelper.custom_message_toast(context, "Task Added");
      });
    } catch (e) {
      debugPrint("Adding Task Error: ${e.toString()}");
    }
  }
}

readData<Widget>(BuildContext context) {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Students')
          .doc(uid)
          .collection("mytasks")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final doc = snapshot.data!.docs;
          // final doc = snapshot.data!.docs.reversed.toList();
          return ListView.builder(
              itemCount: doc.length,
              itemBuilder: (context, index) {
                final time = doc[index].id;
                final String title = doc[index]['title'];
                final String description = doc[index]['description'];
                return InkWell(
                  onTap: () =>
                      updateData(context, uid, time, title, description),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(Color_helper.button_color),
                        foregroundColor: Colors.white,
                        child: Text("${index + 1}"),
                      ),
                      title: Text(title),
                      subtitle: Text(description),
                      trailing: IconButton(
                          icon: const Icon(Icons.delete_outline,color: Color(0xFF103e67),size: 25,),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "Sure To Delete?",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            deleteData(context, time, uid);
                                            WidgetHelper.custom_message_toast(
                                                context, "Task Delete");
                                          },
                                          child: const Text(
                                            "Yes",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 16),
                                          )),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      )
                                    ],
                                  );
                                }));
                          }),
                    ),
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

updateData<Widget>(BuildContext context, final uid, final time, String title,
    final description) async {
  TextEditingController titleController = TextEditingController(text: title);
  TextEditingController descController =
      TextEditingController(text: description);
  final updateFormKey = GlobalKey<FormState>();
  showDialog(
      context: context,
      builder: (context) {
        // print("title: " + title);
        return AlertDialog(
          title: const Text('Update Data'),
          content: Form(
            key: updateFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text("Subject Title"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: RequiredValidator(errorText: "Required"),
                  controller: titleController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text("Subject Description"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: RequiredValidator(errorText: "Required"),
                  controller: descController,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          try {
                            FocusManager.instance.primaryFocus!.unfocus();
                            await FirebaseFirestore.instance
                                .collection("Students")
                                .doc(uid)
                                .collection("mytasks")
                                .doc(time)
                                .set({
                              'title': titleController.text.toString(),
                              'description': descController.text.toString()
                            });
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                          Navigator.pop(context);
                        },
                        child: const Text("Update")))
              ],
            ),
          ),
        );
      });
}

deleteData(BuildContext context, String time, String uid) async {
  try {
    await FirebaseFirestore.instance
        .collection("Students")
        .doc(uid)
        .collection("mytasks")
        .doc(time)
        .delete();
  } catch (e) {
    // print("Error on Deletion-> ${e.toString()}");
  }
}
