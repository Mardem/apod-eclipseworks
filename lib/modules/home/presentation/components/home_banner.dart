import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:eclipseworks_apod/core/utils/toast_notification.dart';
import 'package:eclipseworks_apod/main.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../data/models/local/favorite_service.dart';
import '../../data/models/remote/enums/apod_reaction.dart';
import '../../data/models/remote/mapper/apod_mapper.dart';
import 'home_modal_info.dart';

class HomeBanner extends StatelessWidget {
  HomeBanner({
    super.key,
    required this.details,
  });

  final ApodModel details;

  final FavoriteService favoriteService = inject<FavoriteService>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            right: 4,
            top: 8,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    ToastNotification.success(
                      context: context,
                      title: 'APOD adicionado a gostei!',
                      icon: const Icon(LucideIcons.heart),
                    );

                    final ApodModel item = details.copyWith(
                      reaction: ApodReaction.like,
                    );

                    await favoriteService.add(item: item);
                  },
                  child: const Icon(
                    LucideIcons.heart,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    ToastNotification.success(
                      context: context,
                      title: 'APOD adicionado a não gostei!',
                      icon: const Icon(LucideIcons.heartCrack),
                    );

                    final ApodModel item = details.copyWith(
                      reaction: ApodReaction.unlike,
                    );

                    await favoriteService.add(item: item);
                  },
                  child: const Icon(
                    LucideIcons.heartCrack,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => HomeModalInfo(
                      details: details,
                    ),
                  ),
                  child: const Icon(
                    LucideIcons.info,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
