import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/create_exercisesscreen.dart';
import 'package:flutter_application_1/screens/my_nutrition_plan.dart';
import 'package:flutter_application_1/screens/my_exercise_plan.dart';
import 'package:flutter_application_1/widgets/custom_buttom_navbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/models/grid_exercise.dart';
import 'package:flutter_application_1/widgets/exercise_card.dart';

class MyFitnessPlan extends StatefulWidget {
  final List<Exercise> userExercises;

  const MyFitnessPlan({
    super.key,
    this.userExercises = const [],
  });

  @override
  State<MyFitnessPlan> createState() => _MyFitnessPlanState();
}

class _MyFitnessPlanState extends State<MyFitnessPlan> {
  List<Exercise> _exercises = [];
final int _currentIndex = 2;

  @override
  void initState() {
    super.initState();

    _exercises = List.from(
      widget.userExercises,
    );
  }

  // Merge library exercises with existing exercises
  void mergeLibraryExercises(
    List<GridExercise> selectedExercises,
  ) {
    setState(() {
      for (final gridExercise in selectedExercises) {
        // Check if exercise already exists
        final alreadyExists = _exercises.any(
          (exercise) =>
              exercise.title == gridExercise.name,
        );

        if (!alreadyExists) {
          _exercises.add(
            Exercise(
              title: gridExercise.name,
              muscleGroup:
                  gridExercise.targetMuscles.join(', '),
              difficulty: gridExercise.difficulty,
              assetImage:
                  'assets/images/exercises/${gridExercise.image}',
            ),
          );
        }
      }
    });
  }

  // Widget _buildCurrentScreenContent() {
  //   switch (_currentIndex) {
  //     case 0:
  //       return const Center(
  //         child: Text('Daily Screen'),
  //       );

  //     case 1:
  //       return const Center(
  //         child: Text('Foods Screen'),
  //       );

  //     case 2:
  //       return _buildExercisesBody();

  //     case 3:
  //       return const Center(
  //         child: Text('Statistics Screen'),
  //       );

  //     default:
  //       return _buildExercisesBody();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4D9D9),
      body: Stack(
        children: [
          Positioned.fill(child: _buildExercisesBody()),

          // Header
          Positioned(
            top: 22.h,
            left: 18.w,
            right: 18.w,
            child: Container(
              width: double.infinity,
              height: 111.h,
              decoration: ShapeDecoration(
                color: const Color(0xFF445E75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.r),
                ),
              ),
            ),
          ),

          // My Plan Button
          Positioned(
            left: 90.w,
            top: 75.h,
            child: Opacity(
              opacity: 0.90,
              child: SizedBox(
                width: 78.w,
                height: 26.h,
                child: ElevatedButton(
                  onPressed: () async {
                    final List<GridExercise>?
                        selectedExercises =
                        await Navigator.push<
                            List<GridExercise>>(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const MyExcersisePlan(),
                      ),
                    );

                    if (selectedExercises != null) {
                      mergeLibraryExercises(
                        selectedExercises,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFF7F7),
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    side: const BorderSide(
                      width: 2,
                      color: Color(0xFF445E75),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  child: Text(
                    'My Plan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Exercises Button
          Positioned(
            left: 190.w,
            top: 75.h,
            child: Opacity(
              opacity: 0.90,
              child: SizedBox(
                width: 78.w,
                height: 26.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFF7F7),
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    side: const BorderSide(
                      width: 2,
                      color: Color(0xFF445E75),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  child: Text(
                    'Exercises',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Fitness Title
          Positioned(
            top: 42.h,
            left: 124.w,
            right: 124.w,
            child: Text(
              'Fitness',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Create Exercise Button
          if (_currentIndex == 2)
            Positioned(
              bottom: 85.h,
              right: 15.w,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  height: 34.h,
                  width: 88.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.r),
                    border: Border.all(
                      color: const Color.fromARGB(
                        255,
                        52,
                        72,
                        88,
                      ),
                      width: 2.8,
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(80.r),
                    onTap: () async {
                      final newExercise =
                          await Navigator.push<Exercise>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const CreateExercisesScreen(),
                        ),
                      );

                      if (newExercise != null) {
                        setState(() {
                          _exercises.add(
                            newExercise,
                          );
                        });
                      }
                    },
                    child: Image.asset(
                      'assets/images/Icons/Custom Button.png',
                      width: 90.w,
                      height: 90.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

          // Bottom Navigation
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 10.h,
            child: CustomBottomNavBar(
              currentIndex: 2,
              onItemSelected: (index) {
                if (index == 2) return;

                if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyNutritionPlan(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExercisesBody() {
    return Padding(
      padding: EdgeInsets.only(
        top: 150.h,
      ),
      child: _exercises.isEmpty
          ? Center(
              child: Text(
                'No exercises added yet',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Rubik',
                  color: const Color(0xFF445E75),
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(
                left: 37.w,
                right: 37.w,
                bottom: 110.h,
              ),
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                final exercise = _exercises[index];

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: 12.h,
                  ),
                  child: ExerciseCard(
                    title: exercise.title,
                    muscleGroup: exercise.muscleGroup,
                    difficulty: exercise.difficulty,
                    imageFile: exercise.imageFile,
                    assetImage: exercise.assetImage,
                    onDelete: () {
                      setState(() {
                        _exercises.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}

