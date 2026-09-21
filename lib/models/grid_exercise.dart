class GridExercise {
  final int id;
  final String name;
  final String image;
  final List<String> targetMuscles;
  final String difficulty;

  GridExercise({
    required this.id,
    required this.name,
    required this.image,
    required this.targetMuscles,
    required this.difficulty,
  });

  factory GridExercise.fromJson(Map<String, dynamic> json) {
    return GridExercise(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      targetMuscles: List<String>.from(json['targetMuscles']),
      difficulty: json['difficulty'],
    );
  }
}
