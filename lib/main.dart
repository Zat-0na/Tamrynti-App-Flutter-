import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/my_fitness_plan.dart';
import 'package:flutter_application_1/screens/my_nutrition_plan.dart';
import 'package:flutter_application_1/screens/my_plan_plan.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//import 'screens/customscreen.dart';
//import 'screens/create_exercisesscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(358, 661),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const MyNutritionPlan(),
      ),
    );
  }
}
