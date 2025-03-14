import 'package:eclipseworks_apod/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/date_time.dart';
import '../../data/models/remote/mapper/apod_mapper.dart';
import 'home_modal_info.dart';

class HomeFavoriteVideoCard extends StatelessWidget {
  const HomeFavoriteVideoCard({
    super.key,
    required this.details,
    this.onTap,
  });

  final ApodModel details;
  final VoidCallback? onTap;

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
          GestureDetector(
            onTap: () {
              final Uri videoLink = Uri.parse(details.url);

              _launchUrl(url: videoLink);
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff588aca),
                          Color(0xff2f80ed),
                          Color(0xff2d9ee0)
                        ],
                        stops: [0, 0.5, 1],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      color: Colors.black.withOpacity(.2),
                      child: Icon(
                        LucideIcons.video,
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => HomeModalInfo(
                details: details,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  Text(
                    details.title,
                    style: GoogleFonts.playfair(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.calendarFold,
                        color: AppColors.blue,
                        size: 14,
                      ),
                      Text(
                        DateTimeUtil.formatPtBRDate(date: details.date),
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.darkGrey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchUrl({required Uri url}) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
