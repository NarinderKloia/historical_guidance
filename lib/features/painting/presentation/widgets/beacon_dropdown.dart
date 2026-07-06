import 'package:flutter/material.dart';

import '../../../beacon/data/models/beacon_model.dart';

class BeaconDropdown extends StatelessWidget {
  final List<BeaconModel> beacons;
  final int? selectedBeaconId;
  final ValueChanged<int?> onChanged;

  const BeaconDropdown({
    super.key,
    required this.beacons,
    required this.selectedBeaconId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      value: selectedBeaconId,
      decoration: const InputDecoration(
        labelText: "Beacon",
        border: OutlineInputBorder(),
      ),
      items: [
        const DropdownMenuItem<int?>(value: null, child: Text("No Beacon")),
        ...beacons.map(
          (beacon) => DropdownMenuItem<int?>(
            value: beacon.id,
            child: Text("Major ${beacon.major} • Minor ${beacon.minor}"),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}
