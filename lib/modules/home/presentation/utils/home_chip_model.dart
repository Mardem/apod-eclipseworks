import 'package:flutter/material.dart';

import '../../data/models/remote/enums/apod_reaction.dart';

class HomeChipModel {
  HomeChipModel({
    required this.title,
    required this.icon,
    required this.type,
  });

  final String title;
  final IconData icon;
  final ApodReaction type;
}
