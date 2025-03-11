import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';

class ToastNotification {
  static void success({
    required BuildContext context,
    String? title,
    Icon? icon,
  }) =>
      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 5),
        title: Text(title ?? ''),
        icon: icon,
      );
}
