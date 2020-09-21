part of 'card_bloc.dart';

abstract class CardState extends Equatable {
  const CardState();
}

class CardInitial extends CardState {
  @override
  List<Object> get props => [];
}

class Loading extends CardState {
  @override
  List<Object> get props => [];
}

class Success extends CardState {
  @override
  List<Object> get props => [];
}

class Failed extends CardState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
