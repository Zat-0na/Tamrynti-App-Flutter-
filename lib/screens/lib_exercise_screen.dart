import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/grid_exercise.dart';
import 'package:flutter_application_1/models/exercise_set.dart';
import 'package:flutter_application_1/widgets/number_field.dart';

class LibExerciseScreen extends StatefulWidget {
  final GridExercise exercise;

  const LibExerciseScreen({super.key, required this.exercise});

  @override
  State<LibExerciseScreen> createState() => _LibExerciseScreenState();
}

class _LibExerciseScreenState extends State<LibExerciseScreen> {
  // SETS
  final List<ExerciseSet> sets = [];

  @override
  void initState() {
    super.initState();

    // Default set
    addSet();
  }

  @override
  Widget build(BuildContext context) {
    final GridExercise exercise = widget.exercise;
    return Scaffold(
      backgroundColor: const Color(0xFFE4D9D9),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 45),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // =========================
            // EXERCISE NAME
            // =========================

            Text(
              exercise.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 15),

            // =========================
            // EXERCISE IMAGE
            // =========================
            Container(
              width: double.infinity,
              height: 190,

              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 233, 233),

                borderRadius: BorderRadius.circular(12),

                border: Border.all(color: Colors.black26, width: 2),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),

                child: Image.asset(
                  'assets/images/exercises/${exercise.image}',

                  width: double.infinity,
                  height: double.infinity,

                  fit: BoxFit.cover,

                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 90,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // TARGET MUSCLE + DIFFICULTY
            // =========================
            Row(
              children: [
                // TARGET MUSCLE
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Target Muscle :",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        exercise.targetMuscles.isNotEmpty
                            ? exercise.targetMuscles.first
                            : "none",

                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 5),

                // DIFFICULTY
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Difficulty :",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        exercise.difficulty,

                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // =========================
            // SETS TITLE
            // =========================
            Row(
              children: const [
                Text(
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

            // =========================
            // SETS LIST
            // =========================
            Expanded(
              child: ListView.builder(
                itemCount: sets.length,

                itemBuilder: (context, index) {
                  final ExerciseSet currentSet = sets[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),

                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,

                          child: Text(
                            "Set ${index + 1}",

                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),

                        const SizedBox(width: 5),

                        // WEIGHT
                        Expanded(
                          child: NumberField(
                            controller: currentSet.weightController,
                            hintText: "Kg",
                          ),
                        ),

                        const SizedBox(width: 8),

                        // REPS
                        Expanded(
                          child: NumberField(
                            controller: currentSet.repsController,
                            hintText: "Reps",
                          ),
                        ),

                        const SizedBox(width: 5),

                        // DELETE SET
                        IconButton(
                          onPressed: sets.length == 1
                              ? null
                              : () {
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

            // =========================
            // ADD SET
            // =========================
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

            // =========================
            // CANCEL + DONE
            // =========================
            Row(
              children: [
                // CANCEL
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

                // DONE
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

                      onPressed: () {
                        // Save exercise to workout
                      },

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

  // =========================
  // ADD SET
  // =========================

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

  // =========================
  // REMOVE SET
  // =========================

  void removeSet(int index) {
    if (sets.length == 1) {
      return;
    }

    setState(() {
      sets[index].dispose();
      sets.removeAt(index);
    });
  }

  // =========================
  // DISPOSE
  // =========================

  @override
  void dispose() {
    for (final set in sets) {
      set.dispose();
    }

    super.dispose();
  }
}
