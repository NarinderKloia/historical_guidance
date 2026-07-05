import 'package:flutter/material.dart';

enum PopupAction { edit, delete }

class ActionPopupMenu extends StatelessWidget {
  final Function(PopupAction action) onSelected;

  const ActionPopupMenu({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupAction>(
      onSelected: onSelected,
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: PopupAction.edit,
          child: Row(
            children: [Icon(Icons.edit), SizedBox(width: 10), Text("Edit")],
          ),
        ),
        PopupMenuItem(
          value: PopupAction.delete,
          child: Row(
            children: [Icon(Icons.delete), SizedBox(width: 10), Text("Delete")],
          ),
        ),
      ],
    );
  }
}
