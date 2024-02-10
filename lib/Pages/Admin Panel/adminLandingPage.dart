import 'package:flutter/material.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';
import 'package:riphah_cgpa_calculator/routes.dart';


class AdminLandingPage extends StatelessWidget {
  const AdminLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(Color_helper.background_color),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WidgetHelper.customSizedBox(20),
          Image.asset("lib/Assets/Images/Riphah_Logo.png",scale: 4,),
          WidgetHelper.customSizedBox(60),
          WidgetHelper.CustomElevatedButton(() => WidgetHelper.custom_message_toast(context, 'Module is under Development'), 'Add Faculty to Riphah World'),
          WidgetHelper.customSizedBox(10),
          WidgetHelper.CustomElevatedButton(() => Navigator.pushNamed(context, Routes.adminaddpage), 'Add Admin'),
          WidgetHelper.customSizedBox(10),
          WidgetHelper.CustomElevatedButton(() => WidgetHelper.custom_message_toast(context, 'Module is under Development'), 'Remove Admin'),
          WidgetHelper.customSizedBox(10),
          WidgetHelper.CustomElevatedButton((){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text("Are You Sure to Log Out"),
                actions: [
                  TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("No",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),)),
                  TextButton(onPressed: (){
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.popAndPushNamed(context, Routes.splashScreen);
                  }, child: const Text("Yes",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),)),
                ],
              );
            });
          }, 'Sign Out'),
        ],
      ),
    );
  }
}