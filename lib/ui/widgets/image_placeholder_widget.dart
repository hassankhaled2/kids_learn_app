import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

// Import project utilities (ensure paths are correct for your project)
import 'package:kids_learn_app/utils/app_assets.dart';
import 'package:kids_learn_app/utils/themes/app_colors.dart';

class ImagePlaceholderWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ImagePlaceholderWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        dashPattern: const [10, 6],
        strokeWidth: 2,
        color: AppColors.pinkColor, // Assuming AppColors.pinkColor is accessible
        borderType: BorderType.RRect,
        radius: const Radius.circular(16),
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppAssets.uploadImage, // Assuming AppAssets is defined
              height: 70,
              color: AppColors.pinkColor,
            ),
            const SizedBox(height: 16),
            const Text(
              'Tap to upload an image',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Supported: JPG, PNG',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}