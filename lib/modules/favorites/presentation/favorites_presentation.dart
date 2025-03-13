import 'package:eclipseworks_apod/modules/home/data/models/remote/mapper/apod_mapper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../main.dart';
import '../vm/favorites_viewmodel.dart';
import 'components/favorite_card.dart';

class FavoritesPresentation extends StatefulWidget {
  const FavoritesPresentation({super.key});

  @override
  State<FavoritesPresentation> createState() => _FavoritesPresentationState();
}

class _FavoritesPresentationState extends State<FavoritesPresentation> {
  final FavoritesViewmodel viewModel = inject<FavoritesViewmodel>();

  @override
  void initState() {
    viewModel.loadFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Meus favoritos',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      body: StreamBuilder<List<ApodModel>>(
        stream: viewModel.apod,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<ApodModel>?> snapshot,
        ) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.frown),
                  Text('Sem favoritos por aqui...'),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final ApodModel item = snapshot.data![index];
              return FavoriteCard(details: item, viewModel: viewModel);
            },
          );
        },
      ),
    );
  }
}
