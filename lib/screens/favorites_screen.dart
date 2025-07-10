import 'package:flutter/material.dart';
import 'package:personal_projects/screens/recipe_detail.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
          backgroundColor: Colors.deepPurple[50],
          title: Text('Favorite Recipes')
      ),
      body: favoritesProvider.favorites.isEmpty
          ? Center(child: Text('No favorites yet.')) // if there arent any recipes favorited yet
          : ListView.builder( // show favorited recipes as a list tile and when clicked nav to recipe deatils
        itemCount: favoritesProvider.favorites.length,
        itemBuilder: (context, index) {
          final recipe = favoritesProvider.favorites[index];
          return ListTile(
            leading: Image.network(recipe.image, errorBuilder: (context, _, __) => Icon(Icons.image_not_supported)),
            title: Text(recipe.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailScreen(recipe: recipe),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
