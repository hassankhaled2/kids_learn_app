import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:kids_learn_app/ui/widgets/custom_elevated_button.dart';
import 'package:kids_learn_app/utils/spacing.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:dotted_border/dotted_border.dart';
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
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions;
      // v = recognitions.toString();
      if (recognitions != null && recognitions.isNotEmpty) {
        v = recognitions[0]['label'];
        print('Label: $v'); // Output: Label: 0 Dog

        // If you want to remove the index number (remove "0 " from "0 Dog")
        //    ^ - Matches the start of the string
        //
        //     \d+ - Matches one or more digits (0-9)
        //
        //     \s - Matches a whitespace character (space, tab, etc.)
        //
        //     So ^\d+\s means: "Find a number followed by a space at the beginning of the string"
        // Replaces the first occurrence of the pattern with an empty string (removes it)

        cleanLabel = v.replaceFirst(RegExp(r'^\d+\s'), '');
        print('Clean Label: $cleanLabel');
        // dataList = List<Map<String, dynamic>>.from(jsonDecode(v));
      }
    });

    // Map<String,dynamic>s =_recognitions;
    // print(v[2]);
    print(_recognitions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          'Object Detection',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    color: Colors.deepPurple,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(16),
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/upload-102.png',
                          height: 70,
                          color: Colors.deepPurple,
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
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 16),
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