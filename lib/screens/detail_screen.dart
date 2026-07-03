import 'package:flutter/material.dart';
import '../models/product.dart';

class DetailScreen extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const DetailScreen({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D2D6B),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          product.name,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailImage(imageUrl: product.imageUrl),
            _DetailBody(product: product),
          ],
        ),
      ),
      bottomNavigationBar: _AddToCartBar(
        product: product,
        onAddToCart: () {
          onAddToCart();
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _DetailImage extends StatelessWidget {
  final String imageUrl;

  const _DetailImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: double.infinity,
      height: 250,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: 250,
          color: Colors.grey[100],
          child: const Center(
            child: CircularProgressIndicator(color: Color(0xFF2D2D6B)),
          ),
        );
      },
      errorBuilder: (_, __, ___) => Container(
        height: 250,
        color: Colors.grey[200],
        child: const Icon(
          Icons.image_not_supported,
          size: 60,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  final Product product;

  const _DetailBody({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D6B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            product.brand,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              Text(
                '${product.rating.toStringAsFixed(1)} / 5.0',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(width: 12),
              Icon(Icons.inventory_2, color: Colors.grey[600], size: 16),
              const SizedBox(width: 4),
              Text(
                'Stok: ${product.stock}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D6B),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Description',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Specifications',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _SpecsRow(product: product),
        ],
      ),
    );
  }
}

class _SpecsRow extends StatelessWidget {
  final Product product;

  const _SpecsRow({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SpecCard(
          label: 'Category',
          value: product.category,
          icon: Icons.category,
        ),
        const SizedBox(width: 8),
        _SpecCard(
          label: 'Rating',
          value: product.rating.toStringAsFixed(1),
          icon: Icons.star,
        ),
        const SizedBox(width: 8),
        _SpecCard(
          label: 'Stock',
          value: '${product.stock}',
          icon: Icons.inventory_2,
        ),
      ],
    );
  }
}

class _SpecCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _SpecCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF2D2D6B), size: 20),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(0xFF2D2D6B),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddToCartBar extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const _AddToCartBar({required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onAddToCart,
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              label: const Text(
                'Sepete Ekle',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D2D6B),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
