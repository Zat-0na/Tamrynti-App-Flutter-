import 'dart:io';

class Recipe {
  final String title;
  final String? mealType;
  final double? totalCalories;
  final File? imageFile;
  final String? assetImage;

  Recipe({
    required this.title,
    this.mealType,
    this.totalCalories,
    this.imageFile,
    this.assetImage,
  });
}
