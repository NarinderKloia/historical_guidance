import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_form_page.dart';
import '../../../../shared/widgets/app_primary_button.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../../../shared/widgets/app_text_field.dart';

import '../../data/models/beacon_model.dart';
import '../controllers/beacon_controller.dart';

class EditBeaconPage extends StatefulWidget {
  final BeaconModel beacon;

  const EditBeaconPage({super.key, required this.beacon});

  @override
  State<EditBeaconPage> createState() => _EditBeaconPageState();
}

class _EditBeaconPageState extends State<EditBeaconPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _uuidController;
  late final TextEditingController _majorController;
  late final TextEditingController _minorController;

  final BeaconController _controller = BeaconController.instance;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _uuidController = TextEditingController(text: widget.beacon.uuid);
    _majorController = TextEditingController(
      text: widget.beacon.major.toString(),
    );
    _minorController = TextEditingController(
      text: widget.beacon.minor.toString(),
    );
  }

  @override
  void dispose() {
    _uuidController.dispose();
    _majorController.dispose();
    _minorController.dispose();
    super.dispose();
  }

  Future<void> _updateBeacon() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final beacon = widget.beacon.copyWith(
        uuid: _uuidController.text.trim(),
        major: int.parse(_majorController.text),
        minor: int.parse(_minorController.text),
        updatedAt: DateTime.now(),
      );

      await _controller.updateBeacon(beacon);

      if (!mounted) return;

      AppSnackbar.success(context, "Beacon updated successfully");

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      AppSnackbar.error(context, e.toString());
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Edit Beacon",
      body: AppFormPage(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AppTextField(
                controller: _uuidController,
                label: "UUID",
                validator: (v) =>
                    v == null || v.isEmpty ? "UUID required" : null,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _majorController,
                label: "Major",
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? "Major required" : null,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _minorController,
                label: "Minor",
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? "Minor required" : null,
              ),

              const SizedBox(height: 30),

              AppPrimaryButton(
                text: "Update Beacon",
                isLoading: _isSaving,
                onPressed: _updateBeacon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
