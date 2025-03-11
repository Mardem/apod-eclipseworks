import 'package:cached_network_image/cached_network_image.dart';
import 'package:eclipseworks_apod/modules/home/data/models/remote/mapper/apod_mapper.dart';
import 'package:flutter/material.dart';

import '../../vm/home_viewmodel.dart';

class ImageViewComponent extends StatelessWidget {
  const ImageViewComponent({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApodModel>(
      stream: viewModel.apod,
      builder: (BuildContext context, AsyncSnapshot<ApodModel> snapshot) {
        final ApodModel? apod = snapshot.data;

        if (apod == null) {
          return const SizedBox.shrink();
        }

        return CachedNetworkImage(
          imageUrl: apod.url,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.error, color: Colors.white),
          ),
        );
      },
    );
  }
}
