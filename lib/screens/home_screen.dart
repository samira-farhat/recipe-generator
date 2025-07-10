import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ingredient_provider.dart';
import 'favorites_screen.dart';
import 'recipe_results.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController ingredientController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ingredientProvider= Provider.of<IngredientProvider>(context);
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[50],
        title: Text('Recipe Generator'),
        centerTitle: true,
        actions: [
          // to navigate to the fav recipes page
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FavoritesScreen()),
              );
            },
            icon: Icon(Icons.favorite),
            color: Colors.deepPurple,
            iconSize: 30,
          ),
          SizedBox(width: 15), // for some spacing
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            // add ingredients through the input fields
            Row(

              children: [

                Expanded(
                  child: TextField(
                    controller: ingredientController,
                    decoration: InputDecoration(
                      label: Text('enter ingredients'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(width: 8),

                ElevatedButton(
                    onPressed: () {
                      final input= ingredientController.text;
                      ingredientProvider.addIngredient(input);
                      ingredientController.clear();
                    },
                    child: Text('add'),
                ),

              ],

            ),

            SizedBox(height: 15),

            // Display entered ingredients
            Wrap(
              spacing: 8,
              children: ingredientProvider.ingredients.map((ingredient) {
                return Chip(
                  label: Text(ingredient),
                  onDeleted: () => ingredientProvider.removeIngredient(ingredient),
                );
              }).toList(),
            ),

            SizedBox(height: 15),

            // generate recipes button
            ElevatedButton(
              onPressed: ingredientProvider.ingredients.isNotEmpty // if the ingredients have recipes display them else null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeResultsScreen(
                      ingredients: ingredientProvider.ingredients,
                    ),
                  ),
                );
              }
                  : null,
              child: Text('Generate Recipes'),
            ),


          ],
        ),
      ),
    );
  }
}
