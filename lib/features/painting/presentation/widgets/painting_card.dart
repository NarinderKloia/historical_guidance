import 'package:flutter/material.dart';

import '../../../../shared/widgets/action_popup_menu.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../data/models/painting_model.dart';

class PaintingCard extends StatelessWidget {
  final PaintingModel painting;

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const PaintingCard({
    super.key,
    required this.painting,
    required this.onEdit,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: ListTile(
        onTap: onTap,
        leading: const Icon(Icons.palette),
        title: Text(painting.title),
        subtitle: Text('${painting.artist} (${painting.year})'),
        trailing: ActionPopupMenu(
          onSelected: (action) {
            switch (action) {
              case PopupAction.edit:
                onEdit();
                break;
              case PopupAction.delete:
                onDelete();
                break;
            }
          },
        ),
      ),
    );
  }
}
