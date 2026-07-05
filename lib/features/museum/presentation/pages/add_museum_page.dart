import 'package:flutter/material.dart';
import 'package:historical_guidance/shared/widgets/app_form_page.dart';
import 'package:historical_guidance/shared/widgets/app_primary_button.dart';
import 'package:historical_guidance/shared/widgets/app_scaffold.dart';
import 'package:historical_guidance/shared/widgets/app_snackbar.dart';
import 'package:historical_guidance/shared/widgets/app_text_field.dart';

import '../../data/models/museum_model.dart';
import '../controllers/museum_controller.dart';

class AddMuseumPage extends StatefulWidget {
  const AddMuseumPage({super.key});

  @override
  State<AddMuseumPage> createState() => _AddMuseumPageState();
}

class _AddMuseumPageState extends State<AddMuseumPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _descriptionController = TextEditingController();

  final MuseumController _controller = MuseumController.instance;

  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveMuseum() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final now = DateTime.now().toIso8601String();

      final museum = MuseumModel(
        id: null,
        museumName: _nameController.text.trim(),
        city: _cityController.text.trim(),
        museumDescription: _descriptionController.text.trim(),
        createdAt: now,
        updatedAt: now,
      );

      await _controller.addMuseum(museum);

      if (!mounted) return;

      AppSnackbar.success(context, "Museum added successfully");

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      AppSnackbar.error(context, "Failed to save museum");
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
      title: "Add Museum",
      body: AppFormPage(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AppTextField(
                controller: _nameController,
                label: "Museum Name",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Museum name is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _cityController,
                label: "City",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "City is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _descriptionController,
                label: "Description",
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Description is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              AppPrimaryButton(
                text: "Save Museum",
                isLoading: _isSaving,
                onPressed: _saveMuseum,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
