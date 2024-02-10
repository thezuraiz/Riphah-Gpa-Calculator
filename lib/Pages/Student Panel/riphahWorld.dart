import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';

class RiphahWorld extends StatefulWidget {
  const RiphahWorld({super.key});

  @override
  State<RiphahWorld> createState() => _RiphahWorldState();
}

class _RiphahWorldState extends State<RiphahWorld> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riphah Faculty"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('riphahWorld').snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return ListView(
                padding: const EdgeInsets.only(bottom: 80),
                children:
                snapshot.data!.docs.map((DocumentSnapshot document) {
                  // print("data: ${document["email"]}");
                  // var profilePicture = "${document["profile-Image"]}.png";
                  // print(profilePicture);
                  return Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: const Color(0xFFc0def6),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 20, 20, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                // backgroundColor: Colors.white,
                                // backgroundImage: profilePicture != null
                                //     ? FileImage(File(profilePicture))
                                //     : null, // Set to null if profilePicture is null
                                // child: profilePicture == null
                                //     ? CircularProgressIndicator() // Show CircularProgressIndicator if profilePicture is null
                                //     : null, // Set to null if profilePicture is not null
                                backgroundColor: Colors.white,
                                radius: 55,
                                child: Icon(CupertinoIcons.person,size: 80,),
                              ),
                              WidgetHelper.customSizedBox(10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${document['name']}.",
                                    style: const TextStyle(
                                      color: Color(0xff17416a),
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Card(
                                    shape: const StadiumBorder(),
                                    color: const Color(0xff17416a),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 9),
                                      child: Text("${document['qualification']}"),
                                    ),
                                  )
                                ],
                              ),
                              // Text("Description:",
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 20,
                              //       fontWeight: FontWeight.w500,
                              //     )),
                              WidgetHelper.customSizedBox(15),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 300,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xff17416a)
                                      ),
                                      child: Text('${document['email']}'),
                                      onPressed: () {
                                        var email = document['email'];
                                        Clipboard.setData(
                                            ClipboardData(text: email))
                                            .then(
                                              (value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content: Text("Email Copied!"),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              WidgetHelper.customSizedBox(15),
                            ],
                          ),
                        ),
                      ));
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
