class ProductModel {
  final int? id;
  final String name;
  final String description;
  final double price;
  final bool enabled;
  final String? image;
  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.enabled,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'enabled': enabled,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      enabled: map['enabled'] ?? false,
      image: map['image'],
    );
  }

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    bool? enabled,
    String? image,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      enabled: enabled ?? this.enabled,
      image: image ?? this.image,
    );
  }
}

void main() {
  const String.fromEnvironment('API_URL');
}

class Env {
  static const BASE_URL = String.fromEnvironment('BASE_URL');
}
