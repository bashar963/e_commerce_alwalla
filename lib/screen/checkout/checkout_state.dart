part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
}

class CheckoutInitial extends CheckoutState {
  @override
  List<Object> get props => [];
}

class Loading extends CheckoutState {
  @override
  List<Object> get props => [];
}

class Success extends CheckoutState {
  @override
  List<Object> get props => [];
}

class Failed extends CheckoutState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
