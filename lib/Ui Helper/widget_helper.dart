import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';
import 'package:another_flushbar/flushbar.dart';


class WidgetHelper {
  static customSizedBox(double h) {
    return SizedBox(height: h);
  }

  static custom_error_toast(BuildContext context, final String msg) {
    return Flushbar(
      icon: Icon(Icons.error_outline,color: Colors.white,),
      title: 'Error!',
      messageText: Text(msg, style: const TextStyle(color: Colors.white)),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.red.shade600,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }


  static custom_message_toast(BuildContext context, final String msg) {
    return Flushbar(
      icon: Icon(Icons.done,color: Color(Color_helper.button_color),),
      title: 'Done!',
      messageText: Text(msg, style: const TextStyle(color: Colors.white)),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }

  static Widget CustomElevatedButton(
      final VoidCallback callback, final String msg) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          textStyle:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
        ),
        onPressed: () => callback(),
        child: Text(msg),
      ),
    );
  }

  static alert_widget(BuildContext context, final String titleMessage,
          VoidCallback callback) =>
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              titleMessage,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => callback(),
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          );
        },
      );
}
