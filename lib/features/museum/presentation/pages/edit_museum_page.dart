import 'package:flutter/material.dart';

import '../../data/models/museum_model.dart';
import '../controllers/museum_controller.dart';

class EditMuseumPage extends StatefulWidget {
  final MuseumModel museum;

  const EditMuseumPage({super.key, required this.museum});

  @override
  State<EditMuseumPage> createState() => _EditMuseumPageState();
}

class _EditMuseumPageState extends State<EditMuseumPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _cityController;
  late TextEditingController _descriptionController;

  final MuseumController _controller = MuseumController.instance;

  bool _saving = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.museum.museumName);

    _cityController = TextEditingController(text: widget.museum.city);

    _descriptionController = TextEditingController(
      text: widget.museum.museumDescription,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _updateMuseum() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _saving = true;
    });

    final updatedMuseum = widget.museum.copyWith(
      museumName: _nameController.text.trim(),
      city: _cityController.text.trim(),
      museumDescription: _descriptionController.text.trim(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    await _controller.updateMuseum(updatedMuseum);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Museum")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Museum Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: "City"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _saving ? null : _updateMuseum,
                child: _saving
                    ? const CircularProgressIndicator()
                    : const Text("Update Museum"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
