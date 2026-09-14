import 'dart:io';

class Exercise {
  final String title;
  final String? muscleGroup;
  final String? difficulty;
  final File? imageFile;

  Exercise({
    required this.title,
    this.muscleGroup,
    this.difficulty,
    this.imageFile,
  });
}
