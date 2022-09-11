import 'package:flutter/material.dart';

class Shoes {
  Shoes(
      {this.color,
      this.model,
      this.oldPrice,
      this.currentPrice,
      this.images,
      this.modelNumber});

  final String? model;
  final double? oldPrice;
  final double? currentPrice;
  final List<String>? images;
  final int? modelNumber;
  final Color? color;
}

final shoes = <Shoes>[
  Shoes(
    model: 'Nike Phantom Vision Academy DF MG',
    currentPrice: 379.90,
    oldPrice: 400.00,
    images: [
      'assets/nike/image1-1.png',
      'assets/nike/image1-2.png',
      'assets/nike/image1-3.png'
    ],
    modelNumber: 717,
    color: Colors.red.withOpacity(0.03),
  ),
  Shoes(
    model: 'Nike Tiempo Legend 9 Academy TF',
    currentPrice: 369.90,
    oldPrice: 400.00,
    images: [
      'assets/nike/image2-3.png',
      'assets/nike/image2-2.png',
      'assets/nike/image2-1.png'
    ],
    modelNumber: 75,
    color: Colors.green.withOpacity(0.03),
  ),
  Shoes(
    model: 'Nike Mercurial Superfly 8 Elite FG',
    currentPrice: 1199.90,
    oldPrice: 1300.00,
    images: [
      'assets/nike/image3-1.png',
      'assets/nike/image3-2.png',
      'assets/nike/image3-3.png'
    ],
    modelNumber: 054,
    color: Colors.purpleAccent.withOpacity(0.03),
  ),
  Shoes(
    model: 'Nike Zoom Mercurial Vapor 15 Elite FG',
    currentPrice: 1099.90,
    oldPrice: 1100.00,
    images: [
      'assets/nike/image4-1.png',
      'assets/nike/image4-2.png',
      'assets/nike/image4-3.png'
    ],
    modelNumber: 780,
    color: Colors.blue.withOpacity(0.03),
  ),
];
