import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/models/grid_exercise.dart';
import 'package:flutter_application_1/screens/create_exercisesscreen.dart';
import 'package:flutter_application_1/screens/lib_exercise_screen.dart';
import 'package:flutter_application_1/widgets/custom_buttom_navbar.dart';
import 'package:flutter_application_1/widgets/grid_cards_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyExcersisePlan extends StatefulWidget {
  const MyExcersisePlan({super.key});

  @override
  State<MyExcersisePlan> createState() => _MyExcersisePlanState();
}

class _MyExcersisePlanState extends State<MyExcersisePlan> {
  int _currentIndex = 2;

  // Exercises selected from the library
  List<GridExercise> selectedExercises = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4D9D9),
      body: Stack(
        children: [
          // Main Content
          Positioned.fill(child: _buildCurrentScreenContent()),

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
                  onPressed: () {
                    Navigator.pop(context, selectedExercises);
                  },
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
                      color: const Color.fromARGB(255, 52, 72, 88),
                      width: 2.8,
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(80.r),
                    onTap: () async {
                      await Navigator.push<Exercise>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateExercisesScreen(),
                        ),
                      );
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
              currentIndex: _currentIndex,
              onItemSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentScreenContent() {
    switch (_currentIndex) {
      case 0:
        return const Center(child: Text('Daily Screen'));

      case 1:
        return const Center(child: Text('Foods Screen'));

      case 2:
        return _buildBodyContent();

      case 3:
        return const Center(child: Text('Statistics Screen'));

      default:
        return _buildBodyContent();
    }
  }

  Widget _buildBodyContent() {
    return GridCardsWidget<GridExercise>(
      jsonPath: 'assets/data/exercises.json',

      imagePath: 'assets/images/exercises',

      fromJson: (json) {
        return GridExercise.fromJson(json);
      },

      getId: (exercise) {
        return exercise.id;
      },

      getTitle: (exercise) {
        return exercise.name;
      },

      getImage: (exercise) {
        return exercise.image;
      },

      onItemTap: (exercise) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LibExerciseScreen(exercise: exercise),
          ),
        );
      },

      onItemsSelected: (exercises) {
        setState(() {
          selectedExercises = exercises;
        });
      },
    );
  }
}
