import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:repositories_searcher/model/repositories_model.dart';

class FavoriteService {
  static const _key = 'favorite_repositories';

  Future<List<RepositoryModel>> getFavoriteRepositories() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_key) ?? [];
    return favoritesJson
        .map((json) => RepositoryModel.fromSharedPreferences(jsonDecode(json)))
        .toList();
  }

  Future<void> addFavoriteRepository(RepositoryModel repository) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteRepositories = await getFavoriteRepositories();

    favoriteRepositories.add(repository);

    final favoriteRepositoriesJson =
        favoriteRepositories.map((repo) => jsonEncode(repo.toJson())).toList();

    await prefs.setStringList(_key, favoriteRepositoriesJson);
  }

  Future<void> removeFavoriteRepository(RepositoryModel repository) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteRepositories = await getFavoriteRepositories();

    favoriteRepositories.removeWhere((repo) => repo == repository);

    final favoriteRepositoriesJson =
        favoriteRepositories.map((repo) => jsonEncode(repo.toJson())).toList();

    await prefs.setStringList(_key, favoriteRepositoriesJson);
  }
}
