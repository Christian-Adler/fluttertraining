import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File image) {
    final newPlace = Place(DateTime.now().toString(), pickedTitle, PlaceLocation(0, 0, 'nix'), image);
    _items.add(newPlace);
    notifyListeners();
  }
}
