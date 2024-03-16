import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories_searcher/model/repositories_model.dart';
import 'package:repositories_searcher/services/favorite_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  FavoriteService _favoriteService = FavoriteService();

  Future<void> getFavoriteRepositories() async {
    emit(FavoriteLoading());

    final List<RepositoryModel> favorites =
        await _favoriteService.getFavoriteRepositories();
    emit(FavoriteLoaded(favorites));
  }

  void toggleFavorite(RepositoryModel favorites) {
    if (state is FavoriteLoaded) {
      final repositories = (state as FavoriteLoaded).favorites;
      final index = repositories.indexWhere((element) => element == favorites);
      if (index != -1) {
        _favoriteService.addFavoriteRepository(favorites);

        final updatedRepositories = List<RepositoryModel>.from(repositories);
        final updatedRepository = updatedRepositories[index]
            .copyWith(isFavorite: !favorites.isFavorite);
        updatedRepositories[index] = updatedRepository;
        emit(FavoriteLoaded(updatedRepositories));
      }
    }
  }
}
