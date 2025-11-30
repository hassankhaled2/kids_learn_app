import 'dart:io';
import 'package:flutter/material.dart';

class SelectedImageDisplay extends StatelessWidget {
  final File imageFile;

  const SelectedImageDisplay({
    super.key,
    required this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.file(
        imageFile,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}