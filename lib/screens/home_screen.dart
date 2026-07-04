import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> _cartItems = [];
  final TextEditingController _searchController = TextEditingController();
  List<Product> _products = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadCartFromStorage();
  }

  Future<void> _loadCartFromStorage() async {
    final saved = await LocalStorageService.loadCart();
    setState(() => _cartItems.addAll(saved));
  }

  Future<void> _loadProducts() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      final products = await ApiService.fetchProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ürünler yüklenemedi. Lütfen tekrar deneyin.';
        _isLoading = false;
      });
    }
  }

  Future<void> _onSearchChanged(String query) async {
    if (query.isEmpty) {
      _loadProducts();
      return;
    }
    try {
      setState(() => _isLoading = true);
      final products = await ApiService.searchProducts(query);
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Arama başarısız.';
        _isLoading = false;
      });
    }
  }

  Future<void> _addToCart(Product product) async {
    setState(() => _cartItems.add(product));
    await LocalStorageService.saveCart(_cartItems);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} sepete eklendi!'),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF2D2D6B),
      ),
    );
  }

  Future<void> _removeFromCart(Product product) async {
    setState(() => _cartItems.remove(product));
    await LocalStorageService.saveCart(_cartItems);
  }

  Future<void> _clearCart() async {
    setState(() => _cartItems.clear());
    await LocalStorageService.clearCart();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _HomeAppBar(
        cartCount: _cartItems.length,
        onCartTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CartScreen(
                cartItems: _cartItems,
                onRemove: _removeFromCart,
                onClearCart: _clearCart,
              ),
            ),
          );
        },
      ),
      body: Column(
        children: [
          _BannerWidget(),
          _SearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
          const _SectionTitle(title: 'Ürünler'),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF2D2D6B)),
      );
    }
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text(_errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProducts,
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      );
    }
    return _ProductGrid(products: _products, onAddToCart: _addToCart);
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int cartCount;
  final VoidCallback onCartTap;

  const _HomeAppBar({required this.cartCount, required this.onCartTap});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF2D2D6B),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discover',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Find your perfect device',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: onCartTap,
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
            ),
            if (cartCount > 0)
              Positioned(
                right: 6,
                top: 6,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    '$cartCount',
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2D2D6B), Color(0xFF4A4AAA)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          '🎁 GIFT STORE — Shop now',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D2D6B),
          ),
        ),
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onAddToCart;

  const _ProductGrid({required this.products, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Text('Ürün bulunamadı.', style: TextStyle(color: Colors.grey)),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.68,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onAddToCart: () => onAddToCart(products[index]),
        );
      },
    );
  }
}
