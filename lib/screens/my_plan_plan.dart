import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/screens/create_exercisesscreen.dart';
import 'package:flutter_application_1/screens/my_fitness_plan.dart';
import 'package:flutter_application_1/widgets/custom_buttom_navbar.dart';
import 'package:flutter_application_1/widgets/grid_cards_widget.dart'; 
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPlanPlane extends StatefulWidget {
  const MyPlanPlane({super.key});

  @override
  State<MyPlanPlane> createState() => _MyPlanPlaneState();
}

class _MyPlanPlaneState extends State<MyPlanPlane> {
  int _currentIndex = 2;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4D9D9),
      body: Stack(
        children: [
          Positioned.fill(child: _buildCurrentScreenContent()),

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

          // زر My Plan
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

          // زر Exercises (ينتقل إلى صفحة MyFitnessPlan)
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
                    Navigator.pop(context);
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

  // استخدام الـ Widget الجديدة هنا مباشرة
  Widget _buildBodyContent() {
    return const GridCardsWidget();
  }
}
