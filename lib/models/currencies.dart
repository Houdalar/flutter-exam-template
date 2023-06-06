class Currency {
  final String id;
  final String image;
  final String name;
  final double unitPrice;
  final String code;
  final String description;

  Currency({
    required this.id,
    required this.image,
    required this.name,
    required this.unitPrice,
    required this.code,
    required this.description,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['_id'],
      image: json['image'],
      name: json['name'],
      unitPrice: json['unitPrice'].toDouble(),
      code: json['code'],
      description: json['description'],
    );
  }
}
