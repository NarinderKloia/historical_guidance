import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_text_field.dart';

import '../../../museum/data/models/museum_model.dart';
import '../../data/models/gallery_model.dart';
import '../controllers/gallery_controller.dart';

class AddGalleryPage extends StatefulWidget {
  final MuseumModel museum;

  const AddGalleryPage({super.key, required this.museum});

  @override
  State<AddGalleryPage> createState() => _AddGalleryPageState();
}

class _AddGalleryPageState extends State<AddGalleryPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _floorController = TextEditingController();
  final _descriptionController = TextEditingController();

  final GalleryController _controller = GalleryController.instance;

  @override
  void dispose() {
    _nameController.dispose();
    _floorController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveGallery() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final now = DateTime.now().toIso8601String();

    final gallery = GalleryModel(
      museumId: widget.museum.id!,
      galleryName: _nameController.text.trim(),
      floor: _floorController.text.trim(),
      galleryDescription: _descriptionController.text.trim(),
      createdAt: now,
      updatedAt: now,
    );

    await _controller.addGallery(gallery);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Gallery")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AppTextField(
                controller: _nameController,
                label: "Gallery Name",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter gallery name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: _floorController,
                label: "Floor Number",
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter floor number";
                  }

                  if (int.tryParse(value) == null) {
                    return "Invalid floor number";
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
                    return "Enter description";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              FilledButton(
                onPressed: _saveGallery,
                child: const Text("Save Gallery"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
