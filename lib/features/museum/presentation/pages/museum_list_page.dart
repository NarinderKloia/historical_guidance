import 'package:flutter/material.dart';

import '../controllers/museum_controller.dart';
import '../../data/models/museum_model.dart';
import 'add_museum_page.dart';

class MuseumListPage extends StatefulWidget {
  const MuseumListPage({super.key});

  @override
  State<MuseumListPage> createState() => _MuseumListPageState();
}

class _MuseumListPageState extends State<MuseumListPage> {
  final MuseumController _controller = MuseumController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Museums"), centerTitle: true),
      body: FutureBuilder<List<MuseumModel>>(
        future: _controller.getMuseums(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final museums = snapshot.data ?? [];

          if (museums.isEmpty) {
            return const Center(
              child: Text("No museums found.", style: TextStyle(fontSize: 18)),
            );
          }

          return ListView.builder(
            itemCount: museums.length,
            itemBuilder: (context, index) {
              final museum = museums[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.account_balance),
                  title: Text(museum.museumName),
                  subtitle: Text(museum.city),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddMuseumPage()),
          );

          if (result == true) {
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
