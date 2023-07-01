import 'package:al_hidayah/features/store/ui/product_grid.dart';
import 'package:al_hidayah/widgets/App_Bar.dart';
import 'package:flutter/material.dart';

class ProductStore extends StatefulWidget {
  const ProductStore({super.key});

  @override
  State<ProductStore> createState() => _ProductStoreState();
}

class _ProductStoreState extends State<ProductStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Store"),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ProductGrid(),
      ),
    );
  }
}
