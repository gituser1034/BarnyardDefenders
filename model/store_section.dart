import 'package:flutter/material.dart';

// Olly

// A store section has a header, a grid to select from,
// and each grid to select from is associated with a defender or an object
// Colors is a placeholder
class StoreSection{
  String? sectionHeader;
  int? numberOfSquares;
  List<Object>? storeItems;
  StoreSection({this.sectionHeader, this.numberOfSquares, this.storeItems});
}