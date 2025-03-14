import 'package:eclipseworks_apod/core/utils/toast_notification.dart';
import 'package:eclipseworks_apod/main.dart';
import 'package:eclipseworks_apod/modules/home/data/models/remote/enums/apod_reaction.dart';
import 'package:eclipseworks_apod/modules/home/data/models/remote/mapper/apod_mapper.dart';
import 'package:eclipseworks_apod/modules/home/presentation/components/home_modal_info.dart';
import 'package:eclipseworks_apod/modules/home/vm/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HomeVideoBanner extends StatefulWidget {
  const HomeVideoBanner({
    super.key,
    required this.details,
    this.onAddCallback,
    this.disableButtons = false,
  });

  final ApodModel details;
  final VoidCallback? onAddCallback;
  final bool disableButtons;

  @override
  State<HomeVideoBanner> createState() => _HomeVideoBannerState();
}

class _HomeVideoBannerState extends State<HomeVideoBanner> {
  final HomeViewModel viewModel = inject<HomeViewModel>();

  final _controller = YoutubePlayerController(
    params: const YoutubePlayerParams(
      mute: false,
      showControls: true,
      showFullscreenButton: true,
    ),
  );

  @override
  void initState() {
    _controller.loadVideoByUrl(
      mediaContentUrl: widget.details.url,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YoutubePlayer(controller: _controller),
        if (!widget.disableButtons)
          Positioned(
            right: 4,
            top: 8,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () async => _onClick(
                    context,
                    reaction: ApodReaction.like,
                  ),
                  child: const Icon(
                    LucideIcons.heart,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async => _onClick(
                    context,
                    reaction: ApodReaction.unlike,
                  ),
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
                      details: widget.details,
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
    );
  }

  Future<void> _onClick(
    BuildContext context, {
    required ApodReaction reaction,
  }) async {
    final ApodModel item = widget.details.copyWith(
      reaction: reaction,
    );

    if (widget.onAddCallback != null) {
      widget.onAddCallback!();
    }

    final bool status = await viewModel.add(item: item);

    if (status) {
      ToastNotification.success(
        context: context,
        title: 'APOD adicionado a lista de favoritos!',
        icon: const Icon(LucideIcons.heart),
      );
    } else {
      ToastNotification.error(
        context: context,
        title: 'Já existente nos favoritos!',
        icon: const Icon(LucideIcons.info),
      );
    }
  }
}
