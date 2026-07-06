import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_empty.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../../../shared/widgets/confirm_dialog.dart';

import '../controllers/beacon_controller.dart';
import '../widgets/beacon_card.dart';

import '../../data/models/beacon_model.dart';
import 'add_beacon_page.dart';
import 'edit_beacon_page.dart';

class BeaconListPage extends StatefulWidget {
  const BeaconListPage({super.key});

  @override
  State<BeaconListPage> createState() => _BeaconListPageState();
}

class _BeaconListPageState extends State<BeaconListPage> {
  final BeaconController _controller = BeaconController.instance;

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beacons"), centerTitle: true),

      body: FutureBuilder<List<BeaconModel>>(
        future: _controller.getBeacons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading(message: "Loading beacons...");
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final beacons = snapshot.data ?? [];

          if (beacons.isEmpty) {
            return const AppEmpty(
              title: "No beacons found",
              icon: Icons.bluetooth,
            );
          }

          return ListView.builder(
            itemCount: beacons.length,
            itemBuilder: (context, index) {
              final beacon = beacons[index];

              return BeaconCard(
                beacon: beacon,

                onEdit: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditBeaconPage(beacon: beacon),
                    ),
                  );

                  if (result == true) {
                    _refresh();
                  }
                },

                onDelete: () async {
                  final confirm = await ConfirmDialog.show(
                    context: context,
                    title: "Delete Beacon",
                    message:
                        "Delete Major ${beacon.major} Minor ${beacon.minor} ?",
                  );

                  if (!confirm) return;

                  await _controller.deleteBeacon(beacon.id!);

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Beacon deleted")),
                  );

                  _refresh();
                },
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddBeaconPage()),
          );

          if (result == true) {
            _refresh();
          }
        },
      ),
    );
  }
}
