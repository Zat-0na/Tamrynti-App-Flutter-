class GridRecipe {
  final int id;
  final String title;
  final String image;
  final String mealType;
  final double totalCalories;

  GridRecipe({
    required this.id,
    required this.title,
    required this.image,
    required this.mealType,
    required this.totalCalories,
  });

  factory GridRecipe.fromJson(Map<String, dynamic> json) {
    return GridRecipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      mealType: json['mealType'],
      totalCalories: (json['totalCalories'] as num).toDouble(),
    );
  }
}
