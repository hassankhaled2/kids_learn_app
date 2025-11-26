import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:kids_learn_app/utils/spacing.dart';
import 'package:kids_learn_app/utils/themes/app_colors.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:dotted_border/dotted_border.dart';

import '../widgets/defualt_app_bar_widget.dart';
class ObjectDetectionScreen extends StatefulWidget {
  const ObjectDetectionScreen({super.key});

  @override
  _ObjectDetectionScreenState createState() => _ObjectDetectionScreenState();
}

class _ObjectDetectionScreenState extends State<ObjectDetectionScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;
  var _recognitions;
  var v = "";
  var cleanLabel = '';
  // var dataList = [];
  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }
  final Set<String> _allowedLabels = {'Fox', 'Sheep', 'Horse', 'Cat', 'Dog'};

  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
    print("Model loaded: $res");
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        file = File(image!.path);
      });
      detectimage(file!);
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future detectimage(File image) async {
    // Define a higher confidence  for display
    const double requiredConfidence = 0.70; // 70%

    var recognitions = await Tflite.runModelOnImage(
      //numResults

      //--> How many answers you want.

      // threshold

      //--> Confidence minimum.

      // imageMean / imageStd

      //--> Normalize image pixels correctly.
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _recognitions = recognitions;
      cleanLabel = ''; // Reset label

      if (recognitions != null && recognitions.isNotEmpty) {
        // Get the top recognition result
        //When you call:

        // var recognitions = await Tflite.runModelOnImage(...);

        // It returns a list of detected objects, like this:

        // [
        //   { "label": "0 Dog", "confidence": 0.87 },
        //   { "label": "1 Cat", "confidence": 0.30 },
        //   { "label": "2 Horse", "confidence": 0.05 }
        // ]
        //The results are sorted by confidence score (highest first).
        var topRecognition = recognitions[0];

        // 1. Get the confidence score
        double confidence = topRecognition['confidence'];

        // 2. Get the raw label (e.g., "0 Dog")
        String rawLabel = topRecognition['label'];

        // 3. Remove the index (e.g., "Dog")
        String currentLabel = rawLabel.replaceFirst(RegExp(r'^\d+\s'), '');

        print('Detected Label: $currentLabel with confidence: $confidence');

        // CHECK 1: Is the confidence high enough?
        if (confidence >= requiredConfidence) {
          // CHECK 2: Is the confidently detected label one of the allowed labels?
          if (_allowedLabels.contains(currentLabel)) {
            // Display the confident and allowed label
            cleanLabel = currentLabel;
            v = rawLabel;
          } else {
            // Confident detection, but it's not a supported animal (e.g., Human/Car)
            cleanLabel = 'Not a supported animal.';
          }
        } else {
          // Detection was found, but confidence is too low (e.g., below 70%)
          cleanLabel = 'Detection too weak. Try another image.';
        }
      } else {
        // recognitions list was empty
        cleanLabel = 'No detection found.';
      }
    });

    print(_recognitions);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  getDefaultAppBarWidget(centerTitle: true, context: context, title: 'Animals Detection ', color: AppColors.white54Color, fontWeight: FontWeight.w100),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Note: Only Fox, Sheep, Horse, Cat and Dog can be detected.',style:TextStyle(color: AppColors.white70),),
              verticalSpace(50),
              if (_image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(_image!.path),
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              else
                GestureDetector(
                  onTap: _pickImage,
                  child: DottedBorder(
                    dashPattern: const [10, 6],
                    strokeWidth: 2,
                    color: AppColors.pinkColor,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(16),
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/upload-102.png',
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
                ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 16,color:AppColors.white70),

                ),
              ),

              const SizedBox(height: 25),

              Text(
                cleanLabel,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}