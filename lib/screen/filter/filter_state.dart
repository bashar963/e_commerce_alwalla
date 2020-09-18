part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();
}

class FilterInitial extends FilterState {
  @override
  List<Object> get props => [];
}

class Loading extends FilterState {
  @override
  List<Object> get props => [];
}

class Success extends FilterState {
  @override
  List<Object> get props => [];
}

class Failed extends FilterState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
