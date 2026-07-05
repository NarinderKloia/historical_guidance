import 'package:flutter/material.dart';

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

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Museum")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Museum Name"),
                validator: (value) => value == null || value.trim().isEmpty
                    ? "Museum name is required"
                    : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: "City"),
                validator: (value) => value == null || value.trim().isEmpty
                    ? "City is required"
                    : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) => value == null || value.trim().isEmpty
                    ? "Description is required"
                    : null,
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveMuseum,
                  child: _isSaving
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Save Museum",
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
