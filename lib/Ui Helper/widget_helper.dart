import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';

class WidgetHelper {
  static customSizedBox(double h) {
    return SizedBox(height: h);
  }

  static ToastFuture custom_error_toast(
      BuildContext context, final String msg) {
    return showToast("$msg",
        context: context,
        animation: StyledToastAnimation.fadeScale,
        position: StyledToastPosition.top,
        backgroundColor: Colors.red.shade600,
        textStyle: const TextStyle(color: Colors.white),
        borderRadius: BorderRadius.circular(10));
  }

  static ToastFuture custom_message_toast(
      BuildContext context, final String msg) {
    return showToast('$msg',
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
          padding: EdgeInsets.all(16),
          textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
        ),
        onPressed: () => callback(),
        child: Text(msg),
      ),
    );
  }
}
