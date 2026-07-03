import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String _baseUrl = 'https://dummyjson.com';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products?limit=20'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data['products'];
      return products.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Ürünler yüklenemedi');
    }
  }

  static Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/products/search?q=$query'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data['products'];
      return products.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Arama başarısız');
    }
  }
}
