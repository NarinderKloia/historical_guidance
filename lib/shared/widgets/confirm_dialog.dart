import 'package:flutter/material.dart';

class ConfirmDialog {
  ConfirmDialog._();

  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = "Delete",
    String cancelText = "Cancel",
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(cancelText),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(confirmText),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }
}
