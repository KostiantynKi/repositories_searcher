import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:repositories_searcher/model/repositories_model.dart';

class FavoriteService {
  static const _favoriteKey = 'favorite_repositories';

  // Future<List<RepositoryModel>> getFavoriteRepositories() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final favoritesJson = prefs.getStringList(_favoriteKey) ?? [];
  //   return favoritesJson
  //       .map((json) => RepositoryModel.fromSharedPreferences(jsonDecode(json)))
  //       .toList();
  // }

  Future<List<RepositoryModel>> getFavoriteRepositories() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_favoriteKey) ?? [];
    // prefs.clear();
    final favoriteRepositories = favoritesJson
        .map((json) => RepositoryModel.fromSharedPreferences(jsonDecode(json)))
        .where((repo) => repo.isFavorite)
        .toList();

    return favoriteRepositories;
  }

  Future<void> addFavoriteRepository(RepositoryModel repository) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteRepositories();
    favorites.add(repository);
    final favoriteJson =
        favorites.map((repo) => jsonEncode(repo.toJson())).toList();
    await prefs.setStringList(_favoriteKey, favoriteJson);
  }

  Future<void> removeFavoriteRepository(RepositoryModel repository) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteRepositories();
    favorites.remove(repository);
    final favoriteJson =
        favorites.map((repo) => jsonEncode(repo.toJson())).toList();
    await prefs.setStringList(_favoriteKey, favoriteJson);
  }
}
