import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// تم تعديل الاستيراد أو اسم الموديل هنا بناءً على اسم الملف عندك
import '../models/grid_exercise.dart'; // تأكد إن اسم ملف الموديل كدة أو زي ما سميته

class GridCardsWidget extends StatefulWidget {
  const GridCardsWidget({super.key});

  @override
  State<GridCardsWidget> createState() => _GridCardsWidgetState();
}

class _GridCardsWidgetState extends State<GridCardsWidget> {
  List<GridExercise> exercises = [];

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

          return ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Stack(
              children: [
                // Exercise Image
                Positioned.fill(
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
                        // Add exercise to workout
                      },
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
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
