import 'dart:io';

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Exercise Name + Edit Icon
            if (!isEditing)
              Row(
                children: [
                  Text(
                    exerciseName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 10),

                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        nameController.text = exerciseName;
                        isEditing = true;
                      });
                    },
                  ),
                ],
              ),

            const SizedBox(height: 15),

            /// Image Area
            if (!isEditing)
              GestureDetector(
                onTap: () {
                  _showImagePickerBottomSheet();
                },

                child: Container(
                  width: double.infinity,
                  height: 190,

                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Stack(
                    children: [

                      /// Image / No Image
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

                      /// Add Image Button
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Row(
                          children: [
                            const Text(
                              "Add Image",
                              style: TextStyle(
                                fontSize: 11,
                              ),
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

            /// TextField
            if (isEditing)
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Type here your Exercise name",
                  border: OutlineInputBorder(),
                ),
              ),

            const SizedBox(height: 20),

            /// Done Button
            if (isEditing)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    exerciseName = nameController.text;
                    isEditing = false;
                  });
                },
                child: const Text("Done"),
              ),
          ],
        ),
      ),
    );
  }


  // =========================================================
  // IMAGE PICKER
  // =========================================================

  Future<void> _pickImage(ImageSource source) async {

    final XFile? pickedImage = await imagePicker.pickImage(
      source: source,
    );

    if (!mounted) return;

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }


  // =========================================================
  // BOTTOM SHEET
  // =========================================================

  void _showImagePickerBottomSheet() {

    showModalBottomSheet(
      context: context,

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 20,
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [

                // Gallery
                _imagePickerOption(
                  icon: Icons.photo_library_outlined,
                  label: "Gallery",
                  onTap: () {

                    Navigator.pop(context);

                    _pickImage(ImageSource.gallery);
                  },
                ),

                // Camera
                _imagePickerOption(
                  icon: Icons.camera_alt_outlined,
                  label: "Camera",
                  onTap: () {

                    Navigator.pop(context);

                    _pickImage(ImageSource.camera);
                  },
                ),

                // Delete
                _imagePickerOption(
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


  // =========================================================
  // BOTTOM SHEET OPTION UI
  // =========================================================

  Widget _imagePickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {

    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(15),

      child: Padding(
        padding: const EdgeInsets.all(10),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [

            Container(
              width: 60,
              height: 60,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),

              child: Icon(
                icon,
                size: 30,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}