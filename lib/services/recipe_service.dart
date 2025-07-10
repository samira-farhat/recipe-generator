import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class RecipeService{

  static String _apiKey= 'aceb53b0467e4904be55080dbc7faf3a';
  static String _baseUrl= 'https://api.spoonacular.com';

  static Future<List<Recipe>> fetchRecipes(List<String> ingredients) async{
    final ingredientString= ingredients.join(',');
    final url= Uri.parse('$_baseUrl/recipes/findByIngredients?ingredients=$ingredientString&number=10&apiKey=$_apiKey');

    final response= await http.get(url);

    if(response.statusCode == 200){
      final List jsonData= json.decode(response.body);
      return jsonData.map((item) => Recipe.fromJson(item)).toList();
    }
    else{
      throw Exception('failed to load recipes');
    }
  }

  static Future<Map<String, dynamic>> fetchRecipeDetails(int id) async {
    final url = Uri.parse(
      '$_baseUrl/recipes/$id/information?includeNutrition=false&apiKey=$_apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }

}