import 'package:flutter/material.dart';

class RecipeIngredient {
  final TextEditingController itemController;

  final TextEditingController quantityController;

  final TextEditingController caloriesController;

  final TextEditingController carbsController;

  final TextEditingController proteinController;

  // final TextEditingController fatController;

  RecipeIngredient({
    required this.itemController,
    required this.quantityController,
    required this.caloriesController,
    required this.carbsController,
    required this.proteinController,
    // required this.fatController,
  });

  void dispose() {
    itemController.dispose();
    quantityController.dispose();
    caloriesController.dispose();
    carbsController.dispose();
    proteinController.dispose();
    // fatController.dispose();
  }
}
