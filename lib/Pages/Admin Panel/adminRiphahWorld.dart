import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';

class AdminRiphahWorld extends StatelessWidget {
  const AdminRiphahWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Faculty to Riphah World"),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("riphahFaculty")
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Color(0xFFc0def6),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: const Icon(
                                Icons.person,
                                // size: 60,
                              ),
                              backgroundColor: Colors.white,
                              radius: 55,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      children: [
                                        Text(
                                          "${doc['teacherName']}.",
                                          style: TextStyle(
                                            color: Color(0xff17416a),
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Card(
                                          shape: StadiumBorder(),
                                          color: Color(
                                              0xFF123456), // Change to your color
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                              horizontal: 9,
                                            ),
                                            child: Text(
                                              "${doc['teacherQualification']}",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Expertise:",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("riphahFaculty")
                                          .doc(doc.id)
                                          .collection("expertise")
                                          .snapshots(),
                                      builder: (context, expertiseSnapshot) {
                                        if (expertiseSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        }
                                        if (expertiseSnapshot.hasError) {
                                          return Text(
                                            'Error: ${expertiseSnapshot.error}',
                                            style: TextStyle(color: Colors.red),
                                          );
                                        }
                                        final expertiseDocs = expertiseSnapshot.data!.docs.first.data();
                                        return Wrap(
                                          children: [
                                            Chip(label: Text(expertiseDocs['expertise1']),shape: StadiumBorder(),),
                                            Chip(label: Text(expertiseDocs['expertise2']),shape: StadiumBorder()),
                                            Chip(label: Text(expertiseDocs['expertise3']),shape: StadiumBorder()),
                                          ],
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        WidgetHelper.customSizedBox(15),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(0xFF123456), // Change to your color
                            ),
                            child: const Text('Get Email'),
                            onPressed: () {
                              var email = doc['teacherEmail'];
                              Clipboard.setData(ClipboardData(text: email))
                                  .then(
                                (value) {
                                  WidgetHelper.custom_message_toast(
                                      context, "Email Copied!");
                                },
                              );
                            },
                          ),
                        ),
                      ],
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
