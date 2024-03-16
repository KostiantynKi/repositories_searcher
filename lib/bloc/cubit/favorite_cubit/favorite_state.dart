part of 'favorite_cubit.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteEmpty extends FavoriteState {
  final String errorMessage;

  FavoriteEmpty(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class FavoriteLoaded extends FavoriteState {
  final List<RepositoryModel> favorites;

  FavoriteLoaded(this.favorites);

  @override
  List<Object> get props => [favorites];
}
