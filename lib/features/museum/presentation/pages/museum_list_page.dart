import 'package:flutter/material.dart';
import 'package:historical_guidance/features/gallery/presentation/pages/gallery_list_page.dart';

import 'package:historical_guidance/shared/widgets/action_popup_menu.dart';
import 'package:historical_guidance/shared/widgets/app_card.dart';
import 'package:historical_guidance/shared/widgets/app_empty.dart';
import 'package:historical_guidance/shared/widgets/app_loading.dart';
import 'package:historical_guidance/shared/widgets/confirm_dialog.dart';

import '../controllers/museum_controller.dart';
import '../../data/models/museum_model.dart';
import 'add_museum_page.dart';
import 'edit_museum_page.dart';

class MuseumListPage extends StatefulWidget {
  const MuseumListPage({super.key});

  @override
  State<MuseumListPage> createState() => _MuseumListPageState();
}

class _MuseumListPageState extends State<MuseumListPage> {
  final MuseumController _controller = MuseumController.instance;

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Museums"), centerTitle: true),
      body: FutureBuilder<List<MuseumModel>>(
        future: _controller.getMuseums(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading(message: "Loading museums...");
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final museums = snapshot.data ?? [];

          if (museums.isEmpty) {
            return const AppEmpty(
              title: "No museums found",
              icon: Icons.account_balance,
            );
          }

          return ListView.builder(
            itemCount: museums.length,
            itemBuilder: (context, index) {
              final museum = museums[index];

              return AppCard(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GalleryListPage(museum: museum),
                    ),
                  );

                  _refresh();
                },
                child: ListTile(
                  // -------------------------
                  // Edit / Delete Menu
                  // -------------------------
                  trailing: ActionPopupMenu(
                    onSelected: (action) async {
                      switch (action) {
                        case PopupAction.edit:
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditMuseumPage(museum: museum),
                            ),
                          );

                          if (result == true) {
                            _refresh();
                          }
                          break;

                        case PopupAction.delete:
                          final confirm = await ConfirmDialog.show(
                            context: context,
                            title: "Delete Museum",
                            message:
                                "Are you sure you want to delete '${museum.museumName}'?",
                          );

                          if (confirm) {
                            await _controller.deleteMuseum(museum.id!);

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Museum deleted successfully"),
                              ),
                            );

                            _refresh();
                          }
                          break;
                      }
                    },
                  ),
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
            _refresh();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
