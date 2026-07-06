import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_form_page.dart';
import '../../../../shared/widgets/app_primary_button.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../../../shared/widgets/app_text_field.dart';

import '../../data/models/beacon_model.dart';
import '../controllers/beacon_controller.dart';

class AddBeaconPage extends StatefulWidget {
  const AddBeaconPage({super.key});

  @override
  State<AddBeaconPage> createState() => _AddBeaconPageState();
}

class _AddBeaconPageState extends State<AddBeaconPage> {
  final _formKey = GlobalKey<FormState>();

  final _uuidController = TextEditingController();
  final _majorController = TextEditingController();
  final _minorController = TextEditingController();

  final BeaconController _controller = BeaconController.instance;

  bool _isSaving = false;

  @override
  void dispose() {
    _uuidController.dispose();
    _majorController.dispose();
    _minorController.dispose();
    super.dispose();
  }

  Future<void> _saveBeacon() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final beacon = BeaconModel(
        uuid: _uuidController.text.trim(),
        major: int.parse(_majorController.text),
        minor: int.parse(_minorController.text),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _controller.addBeacon(beacon);

      if (!mounted) return;

      AppSnackbar.success(context, "Beacon added successfully");

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      AppSnackbar.error(context, e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Add Beacon",
      body: AppFormPage(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AppTextField(
                controller: _uuidController,
                label: "UUID",
                validator: (value) =>
                    value == null || value.isEmpty ? "UUID required" : null,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _majorController,
                label: "Major",
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Major required" : null,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _minorController,
                label: "Minor",
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Minor required" : null,
              ),

              const SizedBox(height: 30),

              AppPrimaryButton(
                text: "Save Beacon",
                isLoading: _isSaving,
                onPressed: _saveBeacon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
