class Cat {
  final String id;
  final String name;
  final String? image;
  final String description;
  final String origin;
  final int intelligence;
  final Map<String, dynamic> additionalProperties;

  Cat({
    required this.id,
    required this.name,
    this.image,
    required this.description,
    required this.origin,
    required this.intelligence,
    this.additionalProperties = const {},
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> additionalProperties = {};

    json.forEach((key, value) {
      if (key != 'id' &&
          key != 'name' &&
          key != 'reference_image_id' &&
          key != 'description' &&
          key != 'origin' &&
          key != 'intelligence') {
        additionalProperties[key] = value;
      }
    });

    final image = json['reference_image_id'] != null
        ? 'https://cdn2.thecatapi.com/images/${json['reference_image_id']}.jpg'
        : null;

    return Cat(
      id: json['id'] as String,
      name: json['name'] as String,
      image: image,
      description: json['description'] as String,
      origin: json['origin'] as String,
      intelligence: json['intelligence'] as int,
      additionalProperties: additionalProperties,
    );
  }
}
