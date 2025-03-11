import 'package:cached_network_image/cached_network_image.dart';
import 'package:eclipseworks_apod/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../data/models/remote/mapper/apod_mapper.dart';

class HomeModalInfo extends StatelessWidget {
  const HomeModalInfo({super.key, required this.details});

  final ApodModel details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const SizedBox(height: 30),
          Text(
            details.title,
            style: GoogleFonts.playfair(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: 200,
              imageUrl: details.url,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                LucideIcons.heart,
                size: 16,
                color: AppColors.blue,
              ),
              const SizedBox(width: 4),
              Text(
                details.date,
                style: TextStyle(color: AppColors.darkGrey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(details.explanation)
        ],
      ),
    );
  }
}
