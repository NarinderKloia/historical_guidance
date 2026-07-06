import 'package:flutter/material.dart';

class AudioPickerCard extends StatelessWidget {
  final String? audioPath;
  final VoidCallback onPick;
  final VoidCallback? onRemove;

  const AudioPickerCard({
    super.key,
    required this.audioPath,
    required this.onPick,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final hasAudio = audioPath != null && audioPath!.isNotEmpty;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Painting Audio",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.audiotrack, size: 40),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    hasAudio ? audioPath!.split('/').last : "No audio selected",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onPick,
                    icon: const Icon(Icons.upload_file),
                    label: Text(hasAudio ? "Replace Audio" : "Select Audio"),
                  ),
                ),

                if (hasAudio) ...[
                  const SizedBox(width: 10),

                  IconButton(
                    onPressed: onRemove,
                    icon: const Icon(Icons.delete, color: Colors.red),
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
