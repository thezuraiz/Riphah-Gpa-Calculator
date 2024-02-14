import 'package:flutter/material.dart';
import 'package:riphah_cgpa_calculator/Pages/Admin%20Panel/addadminPage.dart';
import 'package:riphah_cgpa_calculator/Pages/Admin%20Panel/removeAdmin.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';
import 'package:riphah_cgpa_calculator/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminLandingPage extends StatelessWidget {
  AdminLandingPage({super.key,required this.email});
  final email;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(Color_helper.background_color),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WidgetHelper.customSizedBox(20),
          Image.asset(
            "lib/Assets/Images/Riphah_Logo.png",
            scale: 4,
          ),
          WidgetHelper.customSizedBox(60),
          WidgetHelper.CustomElevatedButton(() => Navigator.pushNamed(context, Routes.adminriphahworld),"Add Faculty to Riphah World"),
          WidgetHelper.customSizedBox(10),
          WidgetHelper.CustomElevatedButton(
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddAdminPage(email: email))),
              'Add Admin'),
          WidgetHelper.customSizedBox(10),
          WidgetHelper.CustomElevatedButton(
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => RemoveAdminPage(email: email))), 'Remove Admin'),
          WidgetHelper.customSizedBox(10),
          WidgetHelper.CustomElevatedButton(() {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Are You Sure to Log Out"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.signOut();
                          } catch (e) {
                            debugPrint("Sigout Error: ${e.toString()}");
                          }
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          Navigator.popAndPushNamed(
                              context, Routes.splashScreen);
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "No",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  );
                });
          }, 'Sign Out'),
        ],
      ),
    );
  }
}
