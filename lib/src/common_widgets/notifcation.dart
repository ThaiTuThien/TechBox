import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class NotificationComponent extends StatelessWidget {
  final String title;
  final String description;
  final String type; //* success, error, warning, info

  const NotificationComponent({
    super.key,
    required this.title,
    required this.description,
    required this.type,
  });

  ToastificationType getToastType(String type) {
    return type == 'success' ? ToastificationType.success : 
           type == 'error' ? ToastificationType.error : 
           type == 'warning' ? ToastificationType.warning : 
           ToastificationType.info;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
       toastification.show(
        context: context,
        type: getToastType(type),
        style: ToastificationStyle.flatColored,
        title: Text(title),
        description: Text(description),
        alignment: Alignment.topRight,
        animationDuration: Duration(milliseconds: 500),
        autoCloseDuration: Duration(milliseconds: 1500)
      );
    });
    return SizedBox.shrink();
  }
}
