import 'package:eclipseworks_apod/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeBannerShimmer extends StatelessWidget {
  const HomeBannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: Shimmer.fromColors(
        baseColor: AppColors.darkGrey.withOpacity(.15),
        highlightColor: Colors.white,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          height: 300,
        ),
      ),
    );
  }
}
