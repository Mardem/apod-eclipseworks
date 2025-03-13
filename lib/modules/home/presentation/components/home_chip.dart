import 'package:eclipseworks_apod/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';

import '../utils/home_chip_model.dart';

class HomeChipComponent extends StatelessWidget {
  const HomeChipComponent({
    super.key,
    required this.chipDetail,
    this.onTapCallback,
    this.active = false,
  });

  final bool active;
  final HomeChipModel chipDetail;

  final Function(HomeChipModel)? onTapCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTapCallback != null) {
          onTapCallback!(chipDetail);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: active ? AppColors.blue : AppColors.grey,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Icon(chipDetail.icon, color: _activeColor()),
            const SizedBox(width: 10),
            Text(
              chipDetail.title,
              style: TextStyle(color: _activeColor()),
            ),
          ],
        ),
      ),
    );
  }

  Color _activeColor() => active ? Colors.white : AppColors.blue;
}
