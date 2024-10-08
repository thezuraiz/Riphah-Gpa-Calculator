import 'package:Riphah_CGPA_Calculator/Functions/Admin%20Functions/adminFunc.dart';
import 'package:Riphah_CGPA_Calculator/Ui%20Helper/color.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoveAdminPage extends StatelessWidget {
  RemoveAdminPage({super.key, required this.email});
  final email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admins"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("adminTeachers")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No data available'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];

                return Card(
                  child: ListTile(
                    title: Text(doc['adminEmail']),
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(Color_helper.button_color),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      color: Color(Color_helper.button_color),
                      onPressed: () {
                        debugPrint(doc.id);
                        showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return AlertDialog(
                                content: const Text(
                                  "Are You Sure to remove Admin?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => deleteAdmin(dialogContext, email, doc.id),
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      "No",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
