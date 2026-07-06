import 'package:flutter/material.dart';

import 'features/museum/data/models/museum_model.dart';
import 'features/museum/data/repositories/museum_repository.dart';
import 'features/sender/presentation/pages/sender_dashboard_page.dart';
import 'core/services/nearby/presentation/pages/sender_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = MuseumRepository.instance;

  // Insert a museum
  final museumId = await repository.insertMuseum(
    MuseumModel(
      museumName: 'National Museum',
      city: 'New Delhi',
      museumDescription: 'Historical museum of India',
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    ),
  );

  debugPrint('Inserted Museum ID: $museumId');

  // Read it back
  final museum = await repository.getMuseumById(museumId);

  debugPrint('Museum Data:');
  debugPrint(museum.toString());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: const SenderPage());
  }
}
