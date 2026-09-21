import 'dart:io';

class Exercise {
  final String title;
  final String? muscleGroup;
  final String? difficulty;
  final File? imageFile;

  // For exercises coming from JSON/assets
  final String? assetImage;

  Exercise({
    required this.title,
    this.muscleGroup,
    this.difficulty,
    this.imageFile,
    this.assetImage,
  });
}
