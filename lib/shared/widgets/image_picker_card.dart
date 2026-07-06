import 'dart:io';

import 'package:flutter/material.dart';

class ImagePickerCard extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  const ImagePickerCard({
    super.key,
    required this.imagePath,
    required this.onPick,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (imagePath == null)
              Container(
                height: 180,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: const Text("No Image Selected"),
              )
            else
              Image.file(
                File(imagePath!),
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onPick,
                    icon: const Icon(Icons.image),
                    label: Text(
                      imagePath == null ? "Select Image" : "Replace Image",
                    ),
                  ),
                ),

                if (imagePath != null) ...[
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: onRemove,
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
