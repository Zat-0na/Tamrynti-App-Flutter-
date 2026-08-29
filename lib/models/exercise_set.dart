import 'package:flutter/material.dart';

class ExerciseSet {
  final TextEditingController weightController;
  final TextEditingController repsController;

  ExerciseSet({required this.weightController, required this.repsController});

  void dispose() {
    weightController.dispose();
    repsController.dispose();
  }
}
