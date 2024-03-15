part of 'searcher_cubit.dart';

class SearcherState extends Equatable {
  const SearcherState();

  @override
  List<Object> get props => [];
}

class SearcherInitial extends SearcherState {}

class SearcherLoading extends SearcherState {}

class SearcherEmpty extends SearcherState {}

class SearcherSuccess extends SearcherState {
  final List<RepositoryModel> repositories;

  SearcherSuccess(this.repositories);

  @override
  List<Object> get props => [repositories];
}

class SearcherFailure extends SearcherState {
  final String errorMessage;

  SearcherFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
