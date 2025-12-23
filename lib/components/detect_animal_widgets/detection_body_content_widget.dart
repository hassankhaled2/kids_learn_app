import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kids_learn_app/components/detect_animal_widgets/selected_image_display.dart';
import '../../constants/custom_elevated_button.dart';
import '../../constants/spacing.dart';
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
            const NoteTextWidget(),
            verticalSpace(50),

            selectedImage != null
                ? SelectedImageDisplay(imageFile: selectedImage!)
                : ImagePlaceholderWidget(onTap: onUploadPressed),

            verticalSpace(30),


            customElevatedButton(
              text: "Upload Image",
              onPressed: onUploadPressed,
            ),

            verticalSpace(25),

            // Detection Result
            DetectionResultText(result: detectionResult),

            verticalSpace(20),

            if (!isModelLoaded)
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}