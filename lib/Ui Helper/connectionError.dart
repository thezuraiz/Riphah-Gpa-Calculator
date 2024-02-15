import 'package:Riphah_CGPA_Calculator/Ui%20Helper/color.dart';
import 'package:flutter/material.dart';

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
