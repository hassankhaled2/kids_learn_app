import 'package:flutter/material.dart';
import 'package:kids_learn_app/presentation/widgets/detect_animal_widgets/tFLite_helper_.dart';

import '../../../core/themes/app_colors.dart';


class NoteTextWidget extends StatelessWidget {
  const NoteTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      // Access allowedLabels from the helper class
      'Note: Only ${TFLiteHelper.allowedLabels.join(', ')} can be detected.',
      style: const TextStyle(color: AppColors.white70),
      textAlign: TextAlign.center,
    );
  }
}