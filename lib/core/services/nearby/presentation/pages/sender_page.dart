import 'package:flutter/material.dart';
import 'package:historical_guidance/core/services/nearby/nearby_permission_service.dart';
import 'package:historical_guidance/core/services/nearby/nearby_sender_service.dart';

class SenderPage extends StatefulWidget {
  const SenderPage({super.key});

  @override
  State<SenderPage> createState() => _SenderPageState();
}

class _SenderPageState extends State<SenderPage> {
  final NearbySenderService _sender = NearbySenderService.instance;
  final NearbyPermissionService _permission = NearbyPermissionService.instance;

  bool _isAdvertising = false;
  bool _isBusy = false;

  String _status = "Idle";

  Future<void> _startAdvertising() async {
    setState(() {
      _isBusy = true;
      _status = "Requesting permissions...";
    });

    final granted = await _permission.requestPermissions();

    if (!granted) {
      if (!mounted) return;

      setState(() {
        _isBusy = false;
        _status = "Permissions denied";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please allow all Nearby permissions.")),
      );

      return;
    }

    try {
      await _sender.startAdvertising(deviceName: "Museum Device");

      if (!mounted) return;

      setState(() {
        _isAdvertising = true;
        _isBusy = false;
        _status = "Advertising...";
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isBusy = false;
        _status = "Failed";
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _stopAdvertising() async {
    await _sender.stopAdvertising();

    if (!mounted) return;

    setState(() {
      _isAdvertising = false;
      _status = "Stopped";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Museum Sender"), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isAdvertising
                    ? Icons.bluetooth_searching
                    : Icons.bluetooth_disabled,
                size: 90,
                color: _isAdvertising ? Colors.green : Colors.grey,
              ),

              const SizedBox(height: 24),

              Text(
                _status,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              if (_isBusy) const CircularProgressIndicator(),

              if (!_isBusy)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.wifi_tethering),
                    label: const Text("Start Advertising"),
                    onPressed: _isAdvertising ? null : _startAdvertising,
                  ),
                ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.stop),
                  label: const Text("Stop Advertising"),
                  onPressed: _isAdvertising ? _stopAdvertising : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
