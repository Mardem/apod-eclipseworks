import 'package:eclipseworks_apod/design_system/tokens/colors.dart';
import 'package:eclipseworks_apod/main.dart';
import 'package:eclipseworks_apod/modules/favorites/routes/favorites_routes.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Olá, Eclipse!'),
        GestureDetector(
          onTap: () {
            router.navigateTo(
              context,
              FavoritesRoutesPath.favorites.path,
            );
          },
          child: CircleAvatar(
            backgroundColor: AppColors.blue,
            child: const Icon(
              LucideIcons.heart,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
