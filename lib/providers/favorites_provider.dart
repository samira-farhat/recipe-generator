import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/recipe.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Recipe> _favorites = [];

  List<Recipe> get favorites => _favorites;

  FavoritesProvider() {
    loadFavorites();
  }

  bool isFavorite(Recipe recipe) {
    return _favorites.any((r) => r.id == recipe.id);
  }

  void toggleFavorite(Recipe recipe) async {
    if (isFavorite(recipe)) {
      _favorites.removeWhere((r) => r.id == recipe.id);
    } else {
      _favorites.add(recipe);
    }
    notifyListeners();
    await saveFavorites();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favJson =
    _favorites.map((r) => json.encode({'id': r.id, 'title': r.title, 'image': r.image})).toList();
    await prefs.setStringList('favorites', favJson);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favJson = prefs.getStringList('favorites');

    if (favJson != null) {
      _favorites.clear();
      for (var jsonString in favJson) {
        final map = json.decode(jsonString);
        _favorites.add(Recipe(
          id: map['id'],
          title: map['title'],
          image: map['image'],
        ));
      }
      notifyListeners();
    }
  }
}
