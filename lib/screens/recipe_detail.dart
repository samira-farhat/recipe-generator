import 'package:flutter/material.dart';
import '../services/recipe_service.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../models/recipe.dart';



class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[50],
        title: Text(recipe.title),
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final isFav = favoritesProvider.isFavorite(recipe);
              return IconButton(
                icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: Colors.deepPurple
                ),
                iconSize: 30,
                onPressed: () {
                  favoritesProvider.toggleFavorite(recipe);
                },
              );
            },
          ),
          SizedBox(width: 15),
        ],
      ),

      body: FutureBuilder<Map<String, dynamic>>(
        future: RecipeService.fetchRecipeDetails(recipe.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          final instructions = data['instructions'] ?? 'No instructions provided.';
          final ingredients = data['extendedIngredients'] as List;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Recipe Image
                Image.network(recipe.image, errorBuilder: (context, _, __) => Icon(Icons.image_not_supported)),

                SizedBox(height: 16),

                // Ingredients
                Text('Ingredients:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    )
                ),

                SizedBox(height: 8),

                ...ingredients.map((item) {
                  return Text('• ${item['original']}');
                }).toList(),

                SizedBox(height: 24),

                // Instructions
                Text('Instructions:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    )
                ),

                SizedBox(height: 8),

                Html(data: instructions), // so that the text is shown normally and not in html style

              ],
            ),
          );
        },
      ),
    );
  }
}
