import 'package:flutter/material.dart';

abstract class BlockRepositories {
  int coordinate;
  Color color;

  BlockRepositories({
    required this.coordinate,
    required this.color,
  });
}

class BlockRepositoriesImpl extends BlockRepositories {
  BlockRepositoriesImpl(int coordinate, Color color) : super(coordinate: coordinate, color: color);
}
