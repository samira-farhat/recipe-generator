class Recipe {
  final String title;
  final String image;
  final int id;

  Recipe({required this.title, required this.image, required this.id});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      image: json['image'],
      id: json['id'],
    );
  }
}
