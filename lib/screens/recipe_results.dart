import 'package:flutter/material.dart';
import '/screens/recipe_detail.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';

class RecipeResultsScreen extends StatelessWidget {

  final List<String> ingredients;

  const RecipeResultsScreen({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
          backgroundColor: Colors.deepPurple[50],
          title: Text('Recipes Found')
      ),
      body: FutureBuilder<List<Recipe>>(
        future: RecipeService.fetchRecipes(ingredients),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('No recipes found.')
            );
          }

          final recipes = snapshot.data!;
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.network(
                    recipe.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.image_not_supported, color: Colors.grey);
                    },
                  ),
                  title: Text(recipe.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailScreen(recipe: recipe),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }


}