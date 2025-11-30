import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kids_learn_app/core/app_strings.dart';
import '../../core/themes/app_colors.dart';
import '../../core/defualt_app_bar_widget.dart';
import '../widgets/detect_animal_widgets/detection_body_content_widget.dart';
import '../widgets/detect_animal_widgets/tFLite_helper_.dart';

class ObjectDetectionScreen extends StatefulWidget {
  const ObjectDetectionScreen({super.key});

  @override
  State<ObjectDetectionScreen> createState() => _ObjectDetectionScreenState();
}

class _ObjectDetectionScreenState extends State<ObjectDetectionScreen> {
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  String _detectionResult = AppStrings.readyToDetectText;
  bool _isModelLoaded = false;

  @override
  void initState() {
    super.initState();
    _initTFLiteModel();
  }

  Future<void> _initTFLiteModel() async {
    final bool loaded = await TFLiteHelper.loadModel();
    setState(() {
      _isModelLoaded = loaded;
      if (!loaded) {
        _detectionResult = AppStrings.failedToLoadDetectionModelText;
      }
    });
  }

  /// Handles picking an image from the gallery and running the detection.
  Future<void> _pickImageAndDetect() async {
    // 1. Guard check for model loading
    if (!_isModelLoaded) {
      setState(() => _detectionResult = AppStrings.modelNotLoadedText);
      return;
    }

    try {
      // 2. Pick image
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return; // User canceled selection

      final File imageFile = File(pickedFile.path);

      // 3. Update UI to show selected image and detecting status
      setState(() {
        _selectedImage = imageFile;
        _detectionResult =AppStrings.detectingText;
      });

      // 4. Run detection and update result
      final String result = await TFLiteHelper.detectImage(imageFile);

      setState(() {
        _detectionResult = result;
      });

    } catch (e) {
      print('Error picking or detecting image: $e');
      setState(() {
        _detectionResult = AppStrings.anErrorOccurredCheckPermissionsText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getDefaultAppBarWidget(
        context: context,
        title: AppStrings.animalDetectionText,
        centerTitle: true,
        color: AppColors.white54Color,
        fontWeight: FontWeight.w100,
      ),
      body: DetectionBodyContent(selectedImage: _selectedImage, detectionResult: _detectionResult, isModelLoaded: _isModelLoaded, onUploadPressed: _pickImageAndDetect),
    );
  }
}