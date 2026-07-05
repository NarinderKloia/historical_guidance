import 'package:flutter/material.dart';

class AppEmpty extends StatelessWidget {
  final String title;
  final IconData icon;

  const AppEmpty({
    super.key,
    required this.title,
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 70, color: Colors.grey),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }
}
