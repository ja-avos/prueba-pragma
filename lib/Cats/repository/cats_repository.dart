import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:prueba_pragma/Cats/models/cat_model.dart';
import 'package:http/http.dart' as http;

/// Repository for Cats
class CatsRepository {
  /// Fetches the cats from the API
  Future<List<Cat>> fetchCats() async {
    final response = await http
        .get(Uri.parse('https://api.thecatapi.com/v1/breeds'), headers: {
      'x-api-key': dotenv.env['CAT_API_KEY'] ?? '',
    });

    if (response.statusCode == 200) {
      final List<dynamic> cats = jsonDecode(response.body);
      return cats.map((cat) => Cat.fromJson(cat)).toList();
    } else {
      throw Exception('Failed to load cats');
    }
  }
}
