part of 'searcher_cubit.dart';

class SearcherState extends Equatable {
  const SearcherState();

  @override
  List<Object> get props => [];
}

class SearcherInitial extends SearcherState {}

class SearcherLoading extends SearcherState {}

class SearcherEmpty extends SearcherState {}

class SavedRequests extends SearcherState {
  final List<RepositoryModel> savedRequests;

  SavedRequests(this.savedRequests);

  @override
  List<Object> get props => [savedRequests];
}

class SearcherSuccess extends SearcherState {
  final List<RepositoryModel> searchedRepositories;

  SearcherSuccess(this.searchedRepositories);

  @override
  List<Object> get props => [searchedRepositories];
}

class SearcherFailure extends SearcherState {
  final String errorMessage;

  SearcherFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
