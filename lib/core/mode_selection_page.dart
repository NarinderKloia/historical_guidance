import 'package:flutter/material.dart';
import 'package:historical_guidance/features/sender/presentation/pages/sender_dashboard_page.dart';
import '../../core/services/nearby/presentation/pages/receiver_page.dart';

class ModeSelectionPage extends StatelessWidget {
  const ModeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historical Guidance"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),

            ElevatedButton.icon(
              icon: const Icon(Icons.museum),
              label: const Text("Museum (Sender)"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SenderDashboardPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.phone_android),
              label: const Text("Tourist (Receiver)"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReceiverPage()),
                );
              },
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
