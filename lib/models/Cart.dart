import 'package:flutter/material.dart';

import 'Product.dart';
import 'Product.dart';

class Cart {
  final Product product;
  final int numOfItem;
  final String url;

  Cart(
      {required this.product,
      required this.numOfItem,
      this.url =
          "https://collider.com/wp-content/uploads/playstation-4-controller-2.jpg"});
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 2),
  Cart(product: demoProducts[1], numOfItem: 1),
  Cart(product: demoProducts[3], numOfItem: 1),
];
