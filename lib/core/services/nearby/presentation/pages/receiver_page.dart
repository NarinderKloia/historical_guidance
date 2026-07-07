import 'package:flutter/material.dart';
import 'package:historical_guidance/core/services/nearby/nearby_receiver_service.dart';
import 'qr_scanner_page.dart';

class ReceiverPage extends StatefulWidget {
  const ReceiverPage({super.key});

  @override
  State<ReceiverPage> createState() => _ReceiverPageState();
}

class _ReceiverPageState extends State<ReceiverPage> {
  final NearbyReceiverService _receiver = NearbyReceiverService.instance;

  String? _qrData;
  bool _isDiscovering = false;

  Future<void> _scanQR() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const QRScannerPage()),
    );

    if (result == null) return;

    setState(() {
      _qrData = result;
      _isDiscovering = true;
    });

    try {
      await _receiver.startDiscovery(
        deviceName: "Tourist-${DateTime.now().millisecondsSinceEpoch}",
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Searching for museum device...")),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isDiscovering = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void dispose() {
    _receiver.stopDiscovery();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Receiver")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _scanQR,
              child: const Text("Scan Museum QR"),
            ),

            const SizedBox(height: 24),

            Text(_qrData ?? "No QR scanned", textAlign: TextAlign.center),

            const SizedBox(height: 30),

            if (_isDiscovering) ...[
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 16),
              const Center(child: Text("Searching for nearby museum...")),
            ],
          ],
        ),
      ),
    );
  }
}
