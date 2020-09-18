part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class Loading extends CategoryState {
  @override
  List<Object> get props => [];
}

class Success extends CategoryState {
  @override
  List<Object> get props => [];
}

class Failed extends CategoryState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
