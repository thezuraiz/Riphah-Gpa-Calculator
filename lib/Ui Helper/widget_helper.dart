import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';

class WidgetHelper {
  static customSizedBox(double h) {
    return SizedBox(height: h);
  }

  static ToastFuture custom_error_toast(
      BuildContext context, final String msg) {
    return showToast(msg,
        context: context,
        animation: StyledToastAnimation.fadeScale,
        position: StyledToastPosition.top,
        backgroundColor: Colors.red.shade600,
        textStyle: const TextStyle(color: Colors.white),
        borderRadius: BorderRadius.circular(10));
  }

  static ToastFuture custom_message_toast(
      BuildContext context, final String msg) {
    return showToast(msg,
        context: context,
        animation: StyledToastAnimation.fadeScale,
        position: StyledToastPosition.top,
        backgroundColor: Color(Color_helper.button_color),
        textStyle: const TextStyle(color: Colors.white),
        borderRadius: BorderRadius.circular(20));
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
