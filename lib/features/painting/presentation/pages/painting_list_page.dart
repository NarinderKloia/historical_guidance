import 'package:flutter/material.dart';

import '../../../../shared/widgets/action_popup_menu.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_empty.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../../../shared/widgets/confirm_dialog.dart';

import '../../../gallery/data/models/gallery_model.dart';

import '../../data/models/painting_model.dart';
import '../controllers/painting_controller.dart';
import 'add_painting_page.dart';
import 'edit_painting_page.dart';

class PaintingListPage extends StatefulWidget {
  final GalleryModel gallery;

  const PaintingListPage({super.key, required this.gallery});

  @override
  State<PaintingListPage> createState() => _PaintingListPageState();
}

class _PaintingListPageState extends State<PaintingListPage> {
  final PaintingController _controller = PaintingController.instance;

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gallery.galleryName),
        centerTitle: true,
      ),
      body: FutureBuilder<List<PaintingModel>>(
        future: _controller.getPaintings(widget.gallery.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading(message: "Loading paintings...");
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final paintings = snapshot.data ?? [];

          if (paintings.isEmpty) {
            return const AppEmpty(
              title: "No paintings found",
              icon: Icons.palette,
            );
          }

          return ListView.builder(
            itemCount: paintings.length,
            itemBuilder: (context, index) {
              final painting = paintings[index];

              return AppCard(
                child: ListTile(
                  leading: const Icon(Icons.palette),

                  title: Text(painting.title),

                  subtitle: Text("${painting.artist} • ${painting.year}"),

                  trailing: ActionPopupMenu(
                    onSelected: (action) async {
                      switch (action) {
                        case PopupAction.edit:
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EditPaintingPage(painting: painting),
                            ),
                          );

                          if (result == true) {
                            _refresh();
                          }

                          break;

                        case PopupAction.delete:
                          final confirm = await ConfirmDialog.show(
                            context: context,
                            title: "Delete Painting",
                            message: "Delete '${painting.title}' ?",
                          );

                          if (!confirm) return;

                          await _controller.deletePainting(painting.id!);

                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Painting deleted")),
                          );

                          _refresh();

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
        child: const Icon(Icons.add),

        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddPaintingPage(gallery: widget.gallery),
            ),
          );

          if (result == true) {
            _refresh();
          }
        },
      ),
    );
  }
}
