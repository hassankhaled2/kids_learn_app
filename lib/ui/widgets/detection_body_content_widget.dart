import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kids_learn_app/ui/widgets/selected_image_display.dart';

import 'package:kids_learn_app/utils/spacing.dart';
import 'package:kids_learn_app/ui/widgets/custom_elevated_button.dart';

import 'detection_result_text.dart';
import 'image_placeholder_widget.dart';
import 'note_text_widget.dart';



class DetectionBodyContent extends StatelessWidget {

  final File? selectedImage;
  final String detectionResult;
  final bool isModelLoaded;
  final VoidCallback onUploadPressed;

  const DetectionBodyContent({
    super.key,
    required this.selectedImage,
    required this.detectionResult,
    required this.isModelLoaded,
    required this.onUploadPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Informational Note
            const NoteTextWidget(),
            verticalSpace(50),

            // Image Display or Placeholder
            selectedImage != null
                ? SelectedImageDisplay(imageFile: selectedImage!)
                : ImagePlaceholderWidget(onTap: onUploadPressed),

            verticalSpace(30),

            // Upload Button
            customElevatedButton(
              text: "Upload Image",
              onPressed: onUploadPressed,
            ),

            verticalSpace(25),

            // Detection Result
            DetectionResultText(result: detectionResult),

            verticalSpace(20),

            // Loading Indicator
            if (!isModelLoaded)
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}