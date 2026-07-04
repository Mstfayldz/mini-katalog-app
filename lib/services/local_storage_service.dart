import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class LocalStorageService {
  static const String _cartKey = 'cart_items';

  static Future<void> saveCart(List<Product> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = cartItems
        .map((p) => jsonEncode(p.toJson()))
        .toList();
    await prefs.setStringList(_cartKey, jsonList);
  }

  static Future<List<Product>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_cartKey);
    if (jsonList == null) return [];
    return jsonList.map((json) => Product.fromJson(jsonDecode(json))).toList();
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
