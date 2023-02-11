import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/http_exception.dart';

import '../models/globals.dart'; // with alias to scope all of http.dart

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavoriteStatus() async {
    final url = Uri.https(Globals.backendURL, '/products/$id.json');

    var response = await http.patch(
      url,
      body: json.encode({
        "isFavorite": !isFavorite,
      }),
    );

    if (response.statusCode >= 400) throw HttpException('Update favorite failed!');

    isFavorite = !isFavorite;

    notifyListeners();
  }
}
