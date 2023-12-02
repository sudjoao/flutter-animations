class Character {
  final String name;
  final String description;
  final String image;
  final int id;

  const Character({
    required this.name,
    required this.description,
    required this.image,
    required this.id,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    String description =
        json['description'].isNotEmpty ? json['description'] : 'No description';
    return Character(
      name: json['name'] as String,
      description: description,
      image: json['thumbnail']['path'] + '.' + json['thumbnail']['extension'],
      id: json['id'] as int,
    );
  }

  @override
  String toString() {
    return 'Character{name: $name, description: $description, image: $image, id: $id}';
  }
}
