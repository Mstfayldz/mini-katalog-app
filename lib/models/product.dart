class Product {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final String description;
  final String category;
  final double rating;
  final int stock;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.rating,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['title'],
      brand: json['brand'] ?? 'Unknown',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['thumbnail'],
      description: json['description'],
      category: json['category'],
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'],
    );
  }
}
