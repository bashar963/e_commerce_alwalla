part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class Loading extends HomeState {
  @override
  List<Object> get props => [];
}

class Success extends HomeState {
  @override
  List<Object> get props => [];
}

class Failed extends HomeState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
