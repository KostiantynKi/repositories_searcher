import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories_searcher/model/repositories_model.dart';
import 'package:repositories_searcher/requests/repository_request.dart';
import 'package:repositories_searcher/services/favorite_service.dart';
import 'package:repositories_searcher/services/saved_service.dart';

part 'searcher_state.dart';

class SearcherCubit extends Cubit<SearcherState> {
  SearcherCubit() : super(SearcherInitial());

  FavoriteService favoriteService = FavoriteService();
  SavedRepositoryService savedService = SavedRepositoryService();

  void searchRepositories(String query) async {
    emit(SearcherLoading());
    try {
      final searchedRepositories =
          await RepositoryRequest.searchRepositories(query);
      if (searchedRepositories.isEmpty) {
        emit(SearcherFailure(
            'Nothing was find for your search.\nPlease check the spelling'));
      } else {
        savingRequests(searchedRepositories.first);

        emit(SearcherSuccess(searchedRepositories));
      }
    } catch (e) {
      emit(SearcherFailure('Failed to load repositories'));
    }
  }

  void cleanResult() {
    emit(SearcherEmpty());
  }

  Future<void> getSavedRequests() async {
    emit(SearcherLoading());
    final List<RepositoryModel> savedRequests =
        await savedService.getSavedRepository();
    emit(SavedRequests(savedRequests));
  }

  Future<void> savingRequests(RepositoryModel repository) async {
    await savedService.addSavedRepository(repository);
  }

  void toggleFavorite(RepositoryModel repository) async {
    onToggle(repository);

    await checkOnExistInFavorite(repository);
  }

  void onToggle(RepositoryModel repository) {
    if (state is SearcherSuccess) {
      final searchedRepositories =
          (state as SearcherSuccess).searchedRepositories;
      final searchIndex =
          searchedRepositories.indexWhere((element) => element == repository);
      final updatedRepositories =
          List<RepositoryModel>.from(searchedRepositories);
      final updatedRepository = updatedRepositories[searchIndex]
          .copyWith(isFavorite: !repository.isFavorite);
      updatedRepositories[searchIndex] = updatedRepository;
      emit(SearcherSuccess(updatedRepositories));
    }
  }

  Future<void> checkOnExistInFavorite(RepositoryModel repository) async {
    final List<RepositoryModel> favoriteRepositories =
        await getFavoriteRepositories();
    final favoriteIndex = favoriteRepositories
        .indexWhere((element) => element.name == repository.name);
    if (favoriteIndex == -1) {
      favoriteService.addFavoriteRepository(repository);
    } else if (favoriteIndex != -1) {
      removeFromFavorite(favoriteIndex);
    }
  }

  Future<List<RepositoryModel>> getFavoriteRepositories() async {
    final List<RepositoryModel> favoritesRepository =
        await favoriteService.getFavoriteRepositories();
    return favoritesRepository;
  }

  Future<void> removeFromFavorite(int index) async {
    await favoriteService.removeFromFavorite(index);
  }
}
