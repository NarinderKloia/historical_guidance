import 'package:flutter/material.dart';

import '../../../../shared/widgets/action_popup_menu.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_empty.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../../../shared/widgets/confirm_dialog.dart';

import '../../../museum/data/models/museum_model.dart';

import '../../data/models/gallery_model.dart';
import '../controllers/gallery_controller.dart';
import 'add_gallery_page.dart';
// import 'edit_gallery_page.dart';

class GalleryListPage extends StatefulWidget {
  final MuseumModel museum;

  const GalleryListPage({super.key, required this.museum});

  @override
  State<GalleryListPage> createState() => _GalleryListPageState();
}

class _GalleryListPageState extends State<GalleryListPage> {
  final GalleryController _controller = GalleryController.instance;

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.museum.museumName), centerTitle: true),

      body: FutureBuilder<List<GalleryModel>>(
        future: _controller.getGalleriesByMuseum(widget.museum.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading(message: "Loading galleries...");
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final galleries = snapshot.data ?? [];

          if (galleries.isEmpty) {
            return const AppEmpty(
              title: "No galleries found",
              icon: Icons.photo_library,
            );
          }

          return ListView.builder(
            itemCount: galleries.length,
            itemBuilder: (context, index) {
              final gallery = galleries[index];

              return AppCard(
                child: ListTile(
                  leading: const Icon(Icons.photo_library),

                  title: Text(gallery.galleryName),

                  subtitle: Text("Floor ${gallery.floor}"),

                  // trailing: ActionPopupMenu(
                  //   onSelected: (action) async {
                  //     switch (action) {
                  //       case PopupAction.edit:
                  //         final result = await Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (_) => EditGalleryPage(gallery: gallery),
                  //           ),
                  //         );

                  //         if (result == true) {
                  //           _refresh();
                  //         }

                  //         break;

                  //       case PopupAction.delete:
                  //         final confirm = await ConfirmDialog.show(
                  //           context: context,
                  //           title: "Delete Gallery",
                  //           message: "Delete '${gallery.galleryName}' ?",
                  //         );

                  //         if (confirm) {
                  //           await _controller.deleteGallery(gallery.id!);

                  //           if (!mounted) return;

                  //           ScaffoldMessenger.of(context).showSnackBar(
                  //             const SnackBar(content: Text("Gallery deleted")),
                  //           );

                  //           _refresh();
                  //         }

                  //         break;
                  //     }
                  //   },
                  // ),
                  onTap: () {
                    // Painting List (next module)
                  },
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
            MaterialPageRoute(
              builder: (_) => AddGalleryPage(museum: widget.museum),
            ),
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
