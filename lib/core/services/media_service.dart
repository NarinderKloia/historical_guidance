import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class MediaService {
  MediaService._();

  static final MediaService instance = MediaService._();

  final ImagePicker _imagePicker = ImagePicker();

  // ==========================================================
  // IMAGE
  // ==========================================================

  Future<String?> pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) {
      return null;
    }

    return _copyFileToAppStorage(image.path, "images");
  }

  // ==========================================================
  // AUDIO
  // ==========================================================

  Future<String?> pickAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result == null || result.files.single.path == null) {
      return null;
    }

    return _copyFileToAppStorage(result.files.single.path!, "audio");
  }

  // ==========================================================
  // COPY FILE
  // ==========================================================

  Future<String> _copyFileToAppStorage(String sourcePath, String folder) async {
    final directory = await getApplicationDocumentsDirectory();

    final targetFolder = Directory(p.join(directory.path, folder));

    if (!await targetFolder.exists()) {
      await targetFolder.create(recursive: true);
    }

    final fileExtension = p.extension(sourcePath);

    final fileName = "${DateTime.now().millisecondsSinceEpoch}$fileExtension";

    final destination = p.join(targetFolder.path, fileName);

    final copiedFile = await File(sourcePath).copy(destination);

    return copiedFile.path;
  }

  // ==========================================================
  // DELETE FILE
  // ==========================================================

  Future<void> deleteFile(String? filePath) async {
    if (filePath == null) return;

    final file = File(filePath);

    if (await file.exists()) {
      await file.delete();
    }
  }
}
