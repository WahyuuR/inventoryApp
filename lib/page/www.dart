import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListPage(),
    );
  }
}

class ProductListPage extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'PRINTING HVS', price: 2000, image: 'assets/printing_hvs.png'),
    Product(name: 'STIKER CHROMO', price: 10000, image: 'assets/stiker_chromo.png'),
    Product(name: 'PRINTING A3', price: 1500, image: 'assets/printing_a3.png'),
    Product(name: 'YASIN HARDCOVER', price: 25000, image: 'assets/yasin_hardcover.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MYCOPIER'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}

class Product {
  final String name;
  final int price;
  final String image;

  Product({required this.name, required this.price, required this.image});
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Image.asset(product.image),
        title: Text(product.name),
        subtitle: Text('Rp. ${product.price}'),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            // Tambahkan logika untuk menambahkan ke keranjang
          },
        ),
      ),
    );
  }
}
