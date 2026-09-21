import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/lib_exercise_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/grid_exercise.dart';

class GridCardsWidget extends StatefulWidget {
  final Function(List<GridExercise>) onExercisesSelected;

  const GridCardsWidget({super.key, required this.onExercisesSelected});

  @override
  State<GridCardsWidget> createState() => _GridCardsWidgetState();
}

class _GridCardsWidgetState extends State<GridCardsWidget> {
  List<GridExercise> exercises = [];

  // Exercises selected by the user
  List<GridExercise> selectedExercises = [];

  @override
  void initState() {
    super.initState();
    loadExercises();
  }

  Future<void> loadExercises() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/exercises.json',
    );

    final List<dynamic> jsonData = jsonDecode(jsonString);

    final List<GridExercise> loadedExercises = jsonData
        .map((exercise) => GridExercise.fromJson(exercise))
        .toList();

    setState(() {
      exercises = loadedExercises;
    });
  }

  void addExercise(GridExercise exercise) {
    // Prevent duplicate exercises
    final alreadyAdded = selectedExercises.any(
      (selectedExercise) => selectedExercise.id == exercise.id,
    );

    if (!alreadyAdded) {
      setState(() {
        selectedExercises.add(exercise);
      });

      // Send the updated list to MyPlanPlane
      widget.onExercisesSelected(List.from(selectedExercises));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 145.h,
        left: 16.w,
        right: 16.w,
        bottom: 90.h,
      ),
      child: GridView.builder(
        itemCount: exercises.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14.w,
          mainAxisSpacing: 14.h,
          childAspectRatio: 0.82,
        ),
        itemBuilder: (context, index) {
          final GridExercise exercise = exercises[index];

          final bool isAdded = selectedExercises.any(
            (selectedExercise) => selectedExercise.id == exercise.id,
          );

          return ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Stack(
              children: [
                // Exercise Image
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LibExerciseScreen(exercise: exercise),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/exercises/${exercise.image}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFD0C4C4),
                          child: Center(
                            child: Text(
                              'No Image',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Gradient
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 60.h,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.withOpacity(0.5),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ),

                // Exercise Name
                Positioned(
                  bottom: 12.h,
                  left: 12.w,
                  right: 50.w,
                  child: Text(
                    exercise.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Add Button
                Positioned(
                  bottom: 10.h,
                  right: 10.w,
                  child: Material(
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        addExercise(exercise);
                      },
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: isAdded ? Colors.white : Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isAdded ? Icons.check : Icons.add,
                          color: isAdded ? Colors.black : Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
