import 'package:flutter/material.dart';

class DbranchSkin {
  DbranchSkin({this.color, this.name, this.image});

  final String? name;
  final String? image;
  final int? color;
}

final skins = <DbranchSkin>[
  DbranchSkin(
    name: 'image 1',
    image: 'assets/nike/image1-1.png',
    color: 0xFFa9aaaa,
  ),
  DbranchSkin(
    name: 'image 2',
    image: 'assets/nike/image2-1.png',
    color: 0xFFe2bbbb,
  ),
  DbranchSkin(
    name: 'image 3',
    image: 'assets/nike/image3-1.png',
    color: 0xFFa96b6a,
  ),
  DbranchSkin(
    name: 'image 4',
    image: 'assets/nike/image4-1.png',
    color: 0xFF0a0a0a0,
  ),
  DbranchSkin(
    name: 'image 1',
    image: 'assets/nike/image1-1.png',
    color: 0xFFe16b6a,
  ),
  DbranchSkin(
    name: 'image 2',
    image: 'assets/nike/image2-1.png',
    color: 0xFFe29d6a,
  ),
  DbranchSkin(
    name: 'image 3',
    image: 'assets/nike/image3-1.png',
    color: 0xFFa50b2a,
  ),
  DbranchSkin(
    name: 'image 4',
    image: 'assets/nike/image4-1.png',
    color: 0xFFfaaaa0,
  ),
];
