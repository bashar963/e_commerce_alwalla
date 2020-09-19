part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class Loading extends CartState {
  @override
  List<Object> get props => [];
}

class Success extends CartState {
  @override
  List<Object> get props => [];
}

class Failed extends CartState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
