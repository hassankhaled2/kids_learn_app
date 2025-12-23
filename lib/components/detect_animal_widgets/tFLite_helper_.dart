import 'dart:io';
import 'package:tflite_v2/tflite_v2.dart';

class TFLiteHelper {
  // Define the set of labels that the application is allowed to detect/display.
  static const Set<String> allowedLabels = {'Fox', 'Sheep', 'Horse', 'Cat', 'Dog'};

  // Define the minimum confidence score required for a successful detection.
  static const double requiredConfidence = 0.70; // 70%


  static Future<bool> loadModel() async {
    try {
      String? res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
        numThreads: 1,
      );
      print("TFLite Model loaded: ${res == 'success'}");
      return res == 'success';
    } catch (e) {
      print('Error loading TFLite model: $e');
      return false;
    }
  }


  static Future<String> detectImage(File imageFile) async {
    try {
      var recognitions = await Tflite.runModelOnImage(
        path: imageFile.path,
        numResults: 6,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      if (recognitions == null || recognitions.isEmpty) {
        return 'No detection found.';
      }

      // The results are sorted by confidence, so we only care about the top one.
      final topRecognition = recognitions[0];

      // 1. Get the confidence score
      final double confidence = topRecognition['confidence'] as double;

      // 2. Get the raw label (e.g., "0 Dog")
      final String rawLabel = topRecognition['label'] as String;

      // 3. Remove the index (e.g., "Dog")
      final String currentLabel = rawLabel.replaceFirst(RegExp(r'^\d+\s'), '');

      print('Detected Label: $currentLabel with confidence: $confidence');

      // CHECK 1: Is the confidence high enough?
      if (confidence >= requiredConfidence) {
        // CHECK 2: Is the confidently detected label one of the allowed labels?
        if (allowedLabels.contains(currentLabel)) {
          // Success: Confident and Allowed
          return currentLabel;
        } else {
          // Confident detection, but it's not a supported animal (e.g., Car)
          return 'Not a supported animal.';
        }
      } else {
        // Detection was found, but confidence is too low (e.g., below 70%)
        return 'Detection too weak. Try another image.';
      }
    } catch (e) {
      print('Error during TFLite detection: $e');
      return 'An error occurred during detection.';
    }
  }
}