import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:riphah_cgpa_calculator/Functions/Admin%20Functions/riphahWorldFunc.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';
import 'package:riphah_cgpa_calculator/routes.dart';

class AddRiphahWorld extends StatelessWidget {
  const AddRiphahWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Faculty to Riphah World"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, Routes.add_admin_riphah_world),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                final image = doc['teacherProfilePicture'];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Color(Color_helper.background_color),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (image != null && image != '')
                                ? Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(Color_helper
                                            .button_color), // Define the border color here
                                        width:
                                            2, // Define the border width here
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(image),
                                      radius: 55,
                                    ),
                                  )
                                : const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 55,
                                    child: Icon(
                                      Icons.person_4_outlined,
                                      size: 60,
                                      color: Color(0xFFc0def6),
                                    ),
                                  ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${doc['teacherName']}.",
                                            style: const TextStyle(
                                              color: Color(0xff17416a),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        WidgetHelper.customSizedBox(10),
                                        Card(
                                          shape: const StadiumBorder(),
                                          color: const Color(
                                              0xFF123456), // Change to your color
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                              horizontal: 9,
                                            ),
                                            child: Text(
                                              "${doc['teacherQualification']}",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Expertise:",
                                      style: TextStyle(
                                        color: Color(Color_helper.button_color)
                                            .withOpacity(0.5),
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
                                        if (expertiseSnapshot.connectionState == ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        }
                                        if (expertiseSnapshot.hasError) {
                                          return Text(
                                            'Error: ${expertiseSnapshot.error}',
                                            style: const TextStyle(color: Colors.red),
                                          );
                                        }
                                        if (!expertiseSnapshot.hasData ||
                                            expertiseSnapshot.data!.docs.isEmpty) {
                                          return const Text('No expertise data available');
                                        }
                                        final expertiseDocs = expertiseSnapshot.data!.docs.first.data();
                                        final String expertise1 = expertiseDocs['expertise1'] ?? '';
                                        final String expertise2 = expertiseDocs['expertise2'] ?? '';
                                        final String expertise3 = expertiseDocs['expertise3'] ?? '';

                                        return SizedBox(
                                          width: double.infinity,
                                          child: Wrap(
                                            alignment: WrapAlignment.spaceBetween,
                                            children: [
                                              if (expertise1.isNotEmpty)
                                                Chip(
                                                  label: Text(expertise1),
                                                  shape: const StadiumBorder(),
                                                  backgroundColor: Color(
                                                    Color_helper.white_background_color,
                                                  ).withOpacity(0.5),
                                                ),
                                              if (expertise2.isNotEmpty)
                                                Chip(
                                                  label: Text(expertise2),
                                                  shape: const StadiumBorder(),
                                                  backgroundColor: Color(
                                                    Color_helper.white_background_color,
                                                  ).withOpacity(0.5),
                                                ),
                                              if (expertise3.isNotEmpty)
                                                Chip(
                                                  label: Text(expertise3),
                                                  shape: const StadiumBorder(),
                                                  backgroundColor: Color(
                                                    Color_helper.white_background_color,
                                                  ).withOpacity(0.5),
                                                ),
                                            ],
                                          ),
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
                        Row(children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), // Optional: Define the border radius
                                color: Color(Color_helper.button_color),
                              ),
                              child: Center(
                                child: Text(
                                  "${doc['teacherEmail']}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: ()async{
                                await WidgetHelper.alert_widget(
                                    context,
                                    "Sure to Delete",
                                    () => deleteTeacher(context, doc.id)
                                );
                                debugPrint("Detele Admin Button Call");
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 30,
                              )),
                        ]),
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
