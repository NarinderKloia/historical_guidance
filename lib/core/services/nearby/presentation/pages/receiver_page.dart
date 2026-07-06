import 'package:flutter/material.dart';

import 'qr_scanner_page.dart';

class ReceiverPage extends StatefulWidget {
  const ReceiverPage({super.key});

  @override
  State<ReceiverPage> createState() => _ReceiverPageState();
}

class _ReceiverPageState extends State<ReceiverPage> {
  String? _qrData;

  Future<void> _scanQR() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const QRScannerPage()),
    );

    if (result == null) return;

    setState(() {
      _qrData = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Receiver")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _scanQR,
              child: const Text("Scan Museum QR"),
            ),

            const SizedBox(height: 30),

            Text(_qrData ?? "No QR scanned"),
          ],
        ),
      ),
    );
  }
}
