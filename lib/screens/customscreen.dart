import 'package:flutter/material.dart';

class Customscreen extends StatefulWidget {
  const Customscreen({super.key});

  @override
  State<Customscreen> createState() => _CustomscreenState();
}

class _CustomscreenState extends State<Customscreen> {
  int selectedIndex = 0; // 0 = Custom , 1 = Library

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              height: 130,
              decoration: BoxDecoration(
                color: const Color(0xFF445E75),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // Title
                  const Positioned(
                    top: 30,
                    left: 0,
                    right: 0,
                    child: Text(
                      "Fitness",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),

                  // Buttons
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTabButton("Custom", 0),
                        const SizedBox(width: 16),
                        _buildTabButton("Library", 1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    final bool isSelected = selectedIndex == index;

    return TextButton(
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? const Color(0xFF445E75) : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
