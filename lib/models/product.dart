class Product {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final String description;
  final String size;
  final String audio;
  final String colors;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.size,
    required this.audio,
    required this.colors,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      description: json['description'],
      size: json['size'],
      audio: json['audio'],
      colors: json['colors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'size': size,
      'audio': audio,
      'colors': colors,
    };
  }
}
