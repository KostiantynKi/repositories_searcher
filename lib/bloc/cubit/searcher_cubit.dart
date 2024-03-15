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
      final repositories = await RepositoryRequest.searchRepositories(query);
      if (repositories.isEmpty) {
        emit(SearcherFailure(
            'Nothing was find for your search.\nPlease check the spelling'));
      } else {
        emit(SearcherSuccess(repositories));
      }
    } catch (e) {
      emit(SearcherFailure('Failed to load repositories'));
    }
  }

  void cleanResult() {
    emit(SearcherEmpty());
  }

  void toggleFavorite(RepositoryModel repository) {
    if (state is SearcherSuccess) {
      final repositories = (state as SearcherSuccess).repositories;
      final index = repositories.indexWhere((element) => element == repository);
      if (index != -1) {
        favoriteService.addFavoriteRepository(repository);

        final updatedRepositories = List<RepositoryModel>.from(repositories);
        final updatedRepository = updatedRepositories[index]
            .copyWith(isFavorite: !repository.isFavorite);
        updatedRepositories[index] = updatedRepository;
        emit(SearcherSuccess(updatedRepositories));
      }
    }
  }
}
