import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greatplaces/helpers/db_helper.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];
  static const tablePlaces = 'places';

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(String pickedTitle, File image) async {
    final newPlace = Place(DateTime.now().toString(), pickedTitle, PlaceLocation(0, 0, 'nix'), image);
    _items.add(newPlace);
    notifyListeners();

    await DBHelper.insert(tablePlaces, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> delete(String id) async {
    var idx = _items.indexWhere((item) => item.id == id);
    if (idx < 0) return;
    var place = _items.elementAt(idx);
    try {
      await place.image.delete();
      await DBHelper.delete(tablePlaces, id);
      _items.removeAt(idx);
    } catch (_) {}
    notifyListeners();
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData(tablePlaces);
    _items.clear();
    _items.addAll(dataList
        .map((item) => Place(
              item['id'],
              item['title'],
              PlaceLocation(0, 0, 'nix'),
              File(item['image']),
            ))
        .toList());

    notifyListeners();
  }
}
