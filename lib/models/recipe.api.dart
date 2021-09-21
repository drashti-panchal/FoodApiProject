import 'dart:convert';
import 'package:flutterstaticproject/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
//   var req = unirest("GET", "https://yummly2.p.rapidapi.com/feeds/list");

// req.query({
// 	"start": "0",
// 	"limit": "18",
// 	"tag": "list.recipe.popular"
// });

// req.headers({
// 	"x-rapidapi-host": "yummly2.p.rapidapi.com",
// 	"x-rapidapi-key": "3712ccff2fmshff59cb925172adap1640fcjsn0bc457444c37",
// 	"useQueryString": true
// });

  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "3712ccff2fmshff59cb925172adap1640fcjsn0bc457444c37",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}