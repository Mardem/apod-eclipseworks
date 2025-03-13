import 'package:eclipseworks_apod/modules/home/data/models/remote/enums/apod_reaction.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'home_chip_model.dart';

class HomeChip {
  static List<HomeChipModel> chips() => [
        HomeChipModel(
          title: 'Curti',
          icon: LucideIcons.heart,
          type: ApodReaction.like,
        ),
        HomeChipModel(
          title: 'Não gostei',
          icon: LucideIcons.heartCrack,
          type: ApodReaction.unlike,
        ),
        HomeChipModel(
          title: 'Todos',
          icon: LucideIcons.bookMarked,
          type: ApodReaction.all,
        ),
      ];
}
