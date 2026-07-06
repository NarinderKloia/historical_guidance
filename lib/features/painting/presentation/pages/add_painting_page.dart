import 'package:flutter/material.dart';

import '../../../../core/services/media_service.dart';

import '../../../../shared/widgets/app_form_page.dart';
import '../../../../shared/widgets/app_primary_button.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/audio_picker_card.dart';
import '../../../../shared/widgets/image_picker_card.dart';

import '../../../gallery/data/models/gallery_model.dart';

import '../../../beacon/data/models/beacon_model.dart';
import '../../../beacon/presentation/controllers/beacon_controller.dart';

import '../../data/models/painting_model.dart';
import '../controllers/painting_controller.dart';
import '../widgets/beacon_dropdown.dart';

class AddPaintingPage extends StatefulWidget {
  final GalleryModel gallery;

  const AddPaintingPage({super.key, required this.gallery});

  @override
  State<AddPaintingPage> createState() => _AddPaintingPageState();
}

class _AddPaintingPageState extends State<AddPaintingPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _artistController = TextEditingController();
  final _yearController = TextEditingController();
  final _descriptionController = TextEditingController();

  final PaintingController _controller = PaintingController.instance;
  final BeaconController _beaconController = BeaconController.instance;
  final MediaService _mediaService = MediaService.instance;

  bool _isSaving = false;
  bool _isLoadingBeacons = true;

  List<BeaconModel> _beacons = [];

  int? _selectedBeaconId;

  String? _imagePath;
  String? _audioPath;

  @override
  void initState() {
    super.initState();
    _loadBeacons();
  }

  Future<void> _loadBeacons() async {
    try {
      final result = await _beaconController.getUnassignedBeacons();

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

  Future<void> _pickAudio() async {
    final path = await _mediaService.pickAudio();

    if (path == null) return;

    setState(() {
      _audioPath = path;
    });
  }

  Future<void> _removeAudio() async {
    await _mediaService.deleteFile(_audioPath);

    setState(() {
      _audioPath = null;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _yearController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _savePainting() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final now = DateTime.now().toIso8601String();

      final painting = PaintingModel(
        galleryId: widget.gallery.id!,
        beaconId: _selectedBeaconId,
        title: _titleController.text.trim(),
        artist: _artistController.text.trim(),
        year: _yearController.text.trim(),
        paintingDescription: _descriptionController.text.trim(),
        imagePath: _imagePath,
        audioPath: _audioPath,
        createdAt: now,
        updatedAt: now,
      );

      await _controller.addPainting(painting);

      if (!mounted) return;

      AppSnackbar.success(context, "Painting added successfully");

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
      title: "Add Painting",
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

              const SizedBox(height: 20),

              AudioPickerCard(
                audioPath: _audioPath,
                onPick: _pickAudio,
                onRemove: _removeAudio,
              ),

              const SizedBox(height: 30),

              AppPrimaryButton(
                text: "Save Painting",
                isLoading: _isSaving,
                onPressed: _savePainting,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
