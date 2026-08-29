import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/exercise_set.dart';
import 'package:flutter_application_1/widgets/bottom_sheet_option_ui.dart';
import 'package:flutter_application_1/widgets/custom_dropdown.dart';
import 'package:flutter_application_1/widgets/number_field.dart';
import 'package:image_picker/image_picker.dart';

class CreateExercisesScreen extends StatefulWidget {
  const CreateExercisesScreen({super.key});
  @override
  State<CreateExercisesScreen> createState() => _CreateExercisesScreenState();
}

class _CreateExercisesScreenState extends State<CreateExercisesScreen> {
  TextEditingController nameController = TextEditingController();

  String exerciseName = "";
  bool isEditing = true;

  File? selectedImage;

  final ImagePicker imagePicker = ImagePicker();

  // SETS
  final List<ExerciseSet> sets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4D9D9),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 45),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // EXERCISE NAME + EDIT
            Row(
              children: [
                Text(
                  exerciseName.isEmpty ? "Type Exercise Name" : exerciseName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: exerciseName.isEmpty ? Colors.grey : Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showEditExerciseNameDialog(); // on tap edit icon, show the dialog to edit exercise name
                  },
                ),
              ],
            ),

            const SizedBox(height: 15),

            // IMAGE
            GestureDetector(
              onTap: () {
                _showImagePickerBottomSheet();
              },

              child: Container(
                width: double.infinity,
                height: 190,

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 233, 233),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black26, width: 2),
                ),

                child: Stack(
                  children: [
                    Center(
                      child: selectedImage == null
                          ? const Icon(
                              Icons.image_outlined,
                              size: 90,
                              color: Colors.white,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                selectedImage!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),

                    Positioned(
                      right: 8,
                      bottom: 8,

                      child: Row(
                        children: [
                          const Text(
                            "Add Image",
                            style: TextStyle(fontSize: 11),
                          ),

                          const SizedBox(width: 5),

                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),

                            child: const Icon(
                              Icons.add_circle_outline,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // DIFFICULTY + MUSCLE GROUP
            Row(
              children: [
                Expanded(
                  child: DropdownMenu<String>(
                    width: double.infinity,

                    label: const Text(
                      "Difficulty",
                      style: TextStyle(fontSize: 14),
                    ),

                    inputDecorationTheme: InputDecorationTheme(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),

                    dropdownMenuEntries: <DropdownMenuEntry<String>>[
                      DropdownMenuEntry(value: 'beginner', label: 'Beginner'),
                      DropdownMenuEntry(
                        value: 'intermediate',
                        label: 'Intermediate',
                      ),
                      DropdownMenuEntry(value: 'expert', label: 'Expert'),
                    ],
                  ),
                ),

                const SizedBox(width: 5),

                const Expanded(
                  child: CustomAddableDropdown(width: double.infinity),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // SETS TITLE
            Row(
              children: [
                const Text(
                  "Sets",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                ),
                SizedBox(width: 25),
                Text(
                  "Weight (kg)",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                ),
                SizedBox(width: 40),
                Text(
                  "Reps",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                ),
              ],
            ),

            // SETS LIST
            Expanded(
              child: ListView.builder(
                itemCount: sets.length,

                itemBuilder: (context, index) {
                  final ExerciseSet currentSet = sets[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),

                    child: Row(
                      children: [
                        // Set Number
                        SizedBox(
                          width: 50,
                          child: Text(
                            "Set ${index + 1}",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),

                        const SizedBox(width: 5),

                        // Weight
                        Expanded(
                          child: NumberField(
                            controller: currentSet.weightController,
                            hintText: "Kg",
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Reps
                        Expanded(
                          child: NumberField(
                            controller: currentSet.repsController,
                            hintText: "Reps",
                          ),
                        ),

                        const SizedBox(width: 5),

                        // Delete
                        IconButton(
                          onPressed: () {
                            removeSet(index);
                          },
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ADD SET + BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B6478),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: addSet,
                child: const Text(
                  "+ Add Set",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF6C6C),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE5DDD5),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Colors.black54,
                            width: 1,
                          ),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // FUNCTIONS (METHODS) MOVED TO THE BOTTOM

  // Add Set
  void addSet() {
    setState(() {
      sets.add(
        ExerciseSet(
          weightController: TextEditingController(),
          repsController: TextEditingController(),
        ),
      );
    });
  }

  // Delete Set
  void removeSet(int index) {
    setState(() {
      sets[index].dispose();
      sets.removeAt(index);
    });
  }

  // Image Picker Logic
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedImage = await imagePicker.pickImage(source: source);

    if (!mounted) return;

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  // Bottom Sheet
  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Gallery
                ImagePickerOptionItem(
                  icon: Icons.photo_library_outlined,
                  label: "Gallery",
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),

                // Camera
                ImagePickerOptionItem(
                  icon: Icons.camera_alt_outlined,
                  label: "Camera",
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),

                // Delete
                ImagePickerOptionItem(
                  icon: Icons.delete_outline,
                  label: "Delete",
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedImage = null;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditExerciseNameDialog() {
    nameController.text = exerciseName; // بيحط الاسم القديم جوه الـ TextField

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Exercise Name"),
          content: TextField(
            controller: nameController,
            autofocus: true, // بيفتح الكيبورد ويقف عليها تلقائي
            decoration: const InputDecoration(
              hintText: "Type here your Exercise name",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            // زرار إلغاء
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            // زرار الـ Done جوا الـ Dialog
            ElevatedButton(
              onPressed: () {
                setState(() {
                  exerciseName = nameController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();

    for (final set in sets) {
      set.dispose();
    }
    super.dispose();
  }
}
