import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/create_exercisesscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/widgets/exercise_card.dart';

class MyFitnessPlan extends StatefulWidget {
  final List<Exercise> userExercises;

  const MyFitnessPlan({super.key, this.userExercises = const []});

  @override
  State<MyFitnessPlan> createState() => _MyFitnessPlanState();
}

class _MyFitnessPlanState extends State<MyFitnessPlan> {
  List<Exercise> _exercises = [];

  @override
  void initState() {
    super.initState();
    _exercises = List.from(widget.userExercises);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4D9D9),
      body: Stack(
        children: [
          // 1. Scrollable Cards List
          Positioned.fill(
            top: 150.h,
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
                      bottom: 80.h,
                    ),
                    itemCount: _exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = _exercises[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: ExerciseCard(
                          title: exercise.title,
                          muscleGroup: exercise.muscleGroup,
                          difficulty: exercise.difficulty,
                          imageFile: exercise.imageFile,
                          onDelete: () {
                            setState(() {
                              _exercises.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
          ),

          // 2. Fixed Header Background Box
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

          // "My Plan" Button
          Positioned(
            left: 90.w,
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
                    side: const BorderSide(width: 2, color: Color(0xFF445E75)),
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

          // "Exercises" Button
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
                    side: const BorderSide(width: 2, color: Color(0xFF445E75)),
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

          // Header Title
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

          // 3. Custom Image Icon Button
          Positioned(
            bottom: 10.h,
            right: 15.w,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(80.r),
                onTap: () async {
                  final newExercise = await Navigator.push<Exercise>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateExercisesScreen(),
                    ),
                  );

                  if (newExercise != null) {
                    setState(() {
                      _exercises.add(newExercise);
                    });
                  }
                },
                child: Image.asset(
                  'assets/images/Icons/Custom Button.png',
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
