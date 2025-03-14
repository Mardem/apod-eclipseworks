import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:eclipseworks_apod/core/utils/date_time.dart';
import 'package:eclipseworks_apod/modules/favorites/vm/favorites_viewmodel.dart';
import 'package:eclipseworks_apod/modules/home/data/models/remote/enums/apod_media_type.dart';
import 'package:eclipseworks_apod/modules/home/presentation/components/home_video_banner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '../../../../design_system/design_system.dart';
import '../../../home/data/models/remote/enums/apod_reaction.dart';
import '../../../home/data/models/remote/mapper/apod_mapper.dart';
import 'favorite_modal_info.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    super.key,
    required this.details,
    required this.viewModel,
  });

  final ApodModel details;
  final FavoritesViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 10,
            spreadRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  details.title,
                  style: GoogleFonts.playfair(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          LucideIcons.heart,
                          size: 16,
                          color: AppColors.blue,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateTimeUtil.formatPtBRDate(date: details.date),
                          style: TextStyle(color: AppColors.darkGrey),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: AppColors.blue,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.heart,
                            size: 16,
                            color: AppColors.blue,
                          ),
                          const SizedBox(
                            height: 30,
                            width: 4,
                          ),
                          Text(
                            details.reaction == ApodReaction.like
                                ? 'Curti'
                                : 'Não gostei',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '${details.explanation.substring(0, 200)}...',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 8),
          if (details.mediaType == ApodMediaType.video)
            HomeVideoBanner(details: details),
          if (details.mediaType == ApodMediaType.image)
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    imageUrl: details.url,
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: () => showImageViewer(
                        context,
                        CachedNetworkImageProvider(details.hdUrl),
                        useSafeArea: true,
                        swipeDismissible: true,
                        doubleTapZoomable: true,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        color: Colors.black.withOpacity(.2),
                        child: Icon(
                          LucideIcons.zoomIn,
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) =>
                                FavoriteModalInfo(
                              details: details,
                            ),
                          ),
                          child: const Icon(
                            LucideIcons.info,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () async {
                            final bool status = await viewModel.removeFavorite(
                              favorite: details,
                            );

                            if (status) {
                              toastification.show(
                                context: context,
                                type: ToastificationType.success,
                                description: const Text(
                                  'Um favorito foi removido da lista.',
                                ),
                                autoCloseDuration: const Duration(seconds: 5),
                                title: const Text('Removido dos favoritos!'),
                              );
                            }
                          },
                          child: const Icon(
                            LucideIcons.trash,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
