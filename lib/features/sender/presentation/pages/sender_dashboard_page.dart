import 'package:flutter/material.dart';

import '../../../museum/presentation/pages/museum_list_page.dart';
import '../../../beacon/presentation/pages/beacon_list_page.dart';

class SenderDashboardPage extends StatelessWidget {
  const SenderDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Museum Sender'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DashboardButton(
              title: "Manage Museums",
              icon: Icons.account_balance,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MuseumListPage()),
                );
              },
            ),

            const SizedBox(height: 16),

            DashboardButton(
              title: "Manage Galleries",
              icon: Icons.collections,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Open a museum first to manage its galleries.",
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            DashboardButton(
              title: "Manage Paintings",
              icon: Icons.image,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Open a gallery first to manage its paintings.",
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            DashboardButton(
              title: "Manage Beacons",
              icon: Icons.bluetooth,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BeaconListPage()),
                );
              },
            ),

            const SizedBox(height: 16),

            DashboardButton(
              title: "Generate QR",
              icon: Icons.qr_code,
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Coming soon")));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 28),
        label: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
