import 'package:flutter/material.dart';

class IngredientProvider with ChangeNotifier {
  final List<String> ingredients = [];

  List<String> get ingredientsList => ingredients;

  void addIngredient(String ingredient) {
    if (ingredient.isNotEmpty && !ingredients.contains(ingredient)) {
      ingredients.add(ingredient.trim());
      notifyListeners();
    }
  }

  void removeIngredient(String ingredient) {
    ingredients.remove(ingredient);
    notifyListeners();
  }

  void clearIngredients() {
    ingredients.clear();
    notifyListeners();
  }
}
