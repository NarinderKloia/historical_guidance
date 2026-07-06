import 'package:flutter/material.dart';

import '../../../../core/services/media_service.dart';
import '../../../../shared/widgets/app_form_page.dart';
import '../../../../shared/widgets/app_primary_button.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/image_picker_card.dart';

import '../../../beacon/data/models/beacon_model.dart';
import '../../../beacon/presentation/controllers/beacon_controller.dart';

import '../../data/models/painting_model.dart';
import '../controllers/painting_controller.dart';
import '../widgets/beacon_dropdown.dart';

class EditPaintingPage extends StatefulWidget {
  final PaintingModel painting;

  const EditPaintingPage({super.key, required this.painting});

  @override
  State<EditPaintingPage> createState() => _EditPaintingPageState();
}

class _EditPaintingPageState extends State<EditPaintingPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _artistController;
  late final TextEditingController _yearController;
  late final TextEditingController _descriptionController;

  final PaintingController _controller = PaintingController.instance;
  final BeaconController _beaconController = BeaconController.instance;
  final MediaService _mediaService = MediaService.instance;

  bool _isSaving = false;
  bool _isLoadingBeacons = true;

  List<BeaconModel> _beacons = [];

  int? _selectedBeaconId;
  late String? _imagePath;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.painting.title);
    _artistController = TextEditingController(text: widget.painting.artist);
    _yearController = TextEditingController(text: widget.painting.year);
    _descriptionController = TextEditingController(
      text: widget.painting.paintingDescription,
    );

    _selectedBeaconId = widget.painting.beaconId;
    _imagePath = widget.painting.imagePath;

    _loadBeacons();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _yearController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadBeacons() async {
    try {
      final result = await _beaconController.getAvailableBeaconsForPainting(
        widget.painting.beaconId,
      );

      if (!mounted) return;

      setState(() {
        _beacons = result;
        _isLoadingBeacons = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoadingBeacons = false;
      });

      AppSnackbar.error(context, e.toString());
    }
  }

  Future<void> _pickImage() async {
    final path = await _mediaService.pickImage();

    if (path == null) return;

    if (_imagePath != null) {
      await _mediaService.deleteFile(_imagePath);
    }

    setState(() {
      _imagePath = path;
    });
  }

  Future<void> _removeImage() async {
    await _mediaService.deleteFile(_imagePath);

    setState(() {
      _imagePath = null;
    });
  }

  Future<void> _updatePainting() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final updatedPainting = widget.painting.copyWith(
        title: _titleController.text.trim(),
        artist: _artistController.text.trim(),
        year: _yearController.text.trim(),
        paintingDescription: _descriptionController.text.trim(),
        beaconId: _selectedBeaconId,
        imagePath: _imagePath,
        updatedAt: DateTime.now().toIso8601String(),
      );

      await _controller.updatePainting(updatedPainting);

      if (!mounted) return;

      AppSnackbar.success(context, "Painting updated successfully");

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
      title: "Edit Painting",
      body: AppFormPage(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AppTextField(
                controller: _titleController,
                label: "Painting Title",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Painting title is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _artistController,
                label: "Artist",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Artist is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _yearController,
                label: "Year",
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Year is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _descriptionController,
                label: "Description",
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Description is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              if (_isLoadingBeacons)
                const Center(child: CircularProgressIndicator())
              else
                BeaconDropdown(
                  beacons: _beacons,
                  selectedBeaconId: _selectedBeaconId,
                  onChanged: (value) {
                    setState(() {
                      _selectedBeaconId = value;
                    });
                  },
                ),

              const SizedBox(height: 20),

              ImagePickerCard(
                imagePath: _imagePath,
                onPick: _pickImage,
                onRemove: _removeImage,
              ),

              const SizedBox(height: 30),

              AppPrimaryButton(
                text: "Update Painting",
                isLoading: _isSaving,
                onPressed: _updatePainting,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
