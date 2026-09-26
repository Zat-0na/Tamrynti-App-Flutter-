import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/grid_recipe.dart';
import 'package:flutter_application_1/models/recipe.dart';
import 'package:flutter_application_1/screens/create_recipes_screen.dart';
import 'package:flutter_application_1/screens/lib_recipe_screen.dart';
import 'package:flutter_application_1/widgets/custom_buttom_navbar.dart';
import 'package:flutter_application_1/widgets/grid_cards_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyRecipePlan extends StatefulWidget {
  const MyRecipePlan({super.key});

  @override
  State<MyRecipePlan> createState() => _MyRecipePlanState();
}

class _MyRecipePlanState extends State<MyRecipePlan> {
  int _currentIndex = 1;

  // Recipes selected from the library
  List<GridRecipe> selectedRecipes = [];

  // Recipes created by the user
  List<Recipe> customRecipes = [];

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

          // MY PLAN BUTTON
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
          // Recipes Button
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
                    Navigator.pop(context, selectedRecipes);
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
                    'Recipes',
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
          // Nutrition Title
          Positioned(
            top: 42.h,
            left: 110.w,
            right: 110.w,
            child: Text(
              'Nutrition',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Create Recipe Button
          if (_currentIndex == 1)
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
                      final Recipe? newRecipe = await Navigator.push<Recipe>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateRecipesScreen(),
                        ),
                      );

                      if (newRecipe != null) {
                        setState(() {
                          customRecipes.add(newRecipe);
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
        return _buildBodyContent();

      case 2:
        return const Center(child: Text('Fitness Screen'));

      case 3:
        return const Center(child: Text('Statistics Screen'));

      default:
        return _buildBodyContent();
    }
  }

  Widget _buildBodyContent() {
    return GridCardsWidget<GridRecipe>(
      jsonPath: 'assets/data/recipes.json',

      imagePath: 'assets/images/recipes',

      fromJson: (json) {
        return GridRecipe.fromJson(json);
      },

      getId: (recipe) {
        return recipe.id;
      },

      getTitle: (recipe) {
        return recipe.title;
      },

      getImage: (recipe) {
        return recipe.image;
      },

      onItemTap: (recipe) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LibRecipeScreen(recipe: recipe),
          ),
        );
      },

      onItemsSelected: (recipes) {
        setState(() {
          selectedRecipes = recipes;
        });
      },
    );
  }
}
