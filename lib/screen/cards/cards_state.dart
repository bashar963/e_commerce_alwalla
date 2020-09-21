part of 'cards_bloc.dart';

abstract class CardsState extends Equatable {
  const CardsState();
}

class CardsInitial extends CardsState {
  @override
  List<Object> get props => [];
}

class Loading extends CardsState {
  @override
  List<Object> get props => [];
}

class Success extends CardsState {
  @override
  List<Object> get props => [];
}

class Failed extends CardsState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
