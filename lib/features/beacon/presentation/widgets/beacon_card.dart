import 'package:flutter/material.dart';

import '../../../../shared/widgets/action_popup_menu.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../data/models/beacon_model.dart';

class BeaconCard extends StatelessWidget {
  final BeaconModel beacon;

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BeaconCard({
    super.key,
    required this.beacon,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: ListTile(
        leading: const Icon(Icons.bluetooth),

        title: Text("Major ${beacon.major} • Minor ${beacon.minor}"),

        subtitle: Text(
          beacon.uuid,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

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
