import 'package:cached_network_image/cached_network_image.dart';
import 'package:eclipseworks_apod/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeImageCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback? onTap;

  const HomeImageCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 170,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(231, 231, 231, 1.0),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey,
                    child: const Icon(Icons.error, color: Colors.red),
                  ),
                ),
                Positioned(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.black.withOpacity(.2),
                    child: Icon(
                      LucideIcons.zoomIn,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Text(
                  'NGC 1499: The California Nebula',
                  style: GoogleFonts.playfair(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      LucideIcons.userRound,
                      color: AppColors.blue,
                      size: 14,
                    ),
                    Text(
                      'Toni Fabiani Mendez',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.darkGrey,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      LucideIcons.calendarFold,
                      color: AppColors.blue,
                      size: 14,
                    ),
                    Text(
                      '10/03/2025',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.darkGrey,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
