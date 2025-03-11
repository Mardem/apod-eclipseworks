import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'home_chip_model.dart';

class HomeChip {
  static List<HomeChipModel> chips() => [
        HomeChipModel(title: 'Curti', icon: LucideIcons.heart),
        HomeChipModel(title: 'Detestei', icon: LucideIcons.heartCrack),
        HomeChipModel(title: 'Todos', icon: LucideIcons.bookMarked),
      ];
}
