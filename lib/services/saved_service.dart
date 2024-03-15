import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:repositories_searcher/model/repositories_model.dart';

class SavedRepositoryService {
  static const _key = 'saved_repositories';

  Future<List<RepositoryModel>> getSavedRepository() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_key) ?? [];
    return favoritesJson
        .map((json) => RepositoryModel.fromSharedPreferences(jsonDecode(json)))
        .toList();
  }

  Future<void> addSavedRepository(RepositoryModel repository) async {
    final prefs = await SharedPreferences.getInstance();
    final savedRepository = await getSavedRepository();

    savedRepository.add(repository);

    if (savedRepository.length > 10) {
      savedRepository.removeRange(0, savedRepository.length - 10);
    }

    final savedRepositoryJson =
        savedRepository.map((repo) => jsonEncode(repo.toJson())).toList();

    await prefs.setStringList(_key, savedRepositoryJson);
  }
}
