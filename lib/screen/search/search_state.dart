part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class Loading extends SearchState {
  @override
  List<Object> get props => [];
}

class Success extends SearchState {
  @override
  List<Object> get props => [];
}

class Failed extends SearchState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
