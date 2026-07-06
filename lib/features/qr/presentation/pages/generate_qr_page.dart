import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../shared/widgets/app_scaffold.dart';

class GenerateQrPage extends StatelessWidget {
  const GenerateQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary QR data
    const qrData = '''
{
  "museumId":1,
  "museumName":"Historical Museum",
  "endpointId":"TEMP_ENDPOINT",
  "deviceName":"Museum Device"
}
''';

    return AppScaffold(
      title: "Generate QR",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Museum QR",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 25),

                  QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 250,
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Historical Museum",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const SizedBox(height: 8),

                  const Text("Device : Museum Device"),

                  const SizedBox(height: 8),

                  const Text(
                    "Waiting for tourist...",
                    style: TextStyle(color: Colors.green),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Stop Sharing"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
