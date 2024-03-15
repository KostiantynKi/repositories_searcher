import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/repositories_model.dart';

class RepositoryRequest {
  static const String baseUrl = 'https://api.github.com';

  static Future<List<RepositoryModel>> searchRepositories(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search/repositories?q=$query&per_page=15'),
      headers: {
        'Accept': 'application/vnd.github.v3+json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['items'];
      return data.map((repo) => RepositoryModel.fromJson(repo)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
