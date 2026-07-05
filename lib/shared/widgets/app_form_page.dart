import 'package:flutter/material.dart';

class AppFormPage extends StatelessWidget {
  final Widget child;

  const AppFormPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }
}
