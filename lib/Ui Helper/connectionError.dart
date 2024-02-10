import 'package:flutter/material.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Color(Color_helper.background_color),
          child: Center(
            child: Image.asset("lib/Assets/Icons/something_wrong.jpg"),
          ),
        )
    );
  }
}
