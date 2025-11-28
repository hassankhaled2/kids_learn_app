import 'package:flutter/material.dart';
import 'package:kids_learn_app/ui/widgets/tFLite_helper_.dart';

// Ensure this path points to your actual TFLite helper file
import 'package:kids_learn_app/utils/themes/app_colors.dart';

class NoteTextWidget extends StatelessWidget {
  const NoteTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      // Access allowedLabels from the helper class
      'Note: Only ${TFLiteHelper.allowedLabels.join(', ')} can be detected.',
      style: TextStyle(color: AppColors.white70),
      textAlign: TextAlign.center,
    );
  }
}