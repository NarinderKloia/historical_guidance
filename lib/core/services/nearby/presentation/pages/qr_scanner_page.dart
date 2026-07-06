import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool _scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Museum QR")),
      body: MobileScanner(
        onDetect: (capture) {
          if (_scanned) return;

          final barcode = capture.barcodes.first;

          final value = barcode.rawValue;

          if (value == null) return;

          _scanned = true;

          Navigator.pop(context, value);
        },
      ),
    );
  }
}
