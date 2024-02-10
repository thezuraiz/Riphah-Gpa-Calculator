import 'package:flutter/material.dart';
import 'package:riphah_cgpa_calculator/Functions/landingpageFunc.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';
import 'package:riphah_cgpa_calculator/routes.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            WidgetHelper.customSizedBox(30),
            Hero(
              tag: const Key("Logo_Animation"),
              child: Image.asset("lib/Assets/Images/Riphah_Logo.png", scale: 4),
            ),
            WidgetHelper.customSizedBox(40),
            WidgetHelper.CustomElevatedButton(() => Navigator.pushNamed(context, Routes.gpa), "GPA Calculator"),
            WidgetHelper.customSizedBox(15),
            WidgetHelper.CustomElevatedButton(
                () => Navigator.pushNamed(context, Routes.cgpa),
                "CGPA Calculator"),
            WidgetHelper.customSizedBox(15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                ),
                onPressed: () => Navigator.pushNamed(context, Routes.todomainpage),
                child: const Text(
                  "TODO Task",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ),
            WidgetHelper.customSizedBox(15),
            WidgetHelper.CustomElevatedButton(() => Navigator.pushNamed(context, Routes.riphahWorld), "RIPHAH World"),
            WidgetHelper.customSizedBox(15),
            WidgetHelper.CustomElevatedButton(
                () => signoutButton(context), "Sign Out")
          ],
        ),
      ),
    );
  }
}
