part of 'loyalty_bloc.dart';

abstract class LoyaltyState extends Equatable {
  const LoyaltyState();
}

class LoyaltyInitial extends LoyaltyState {
  @override
  List<Object> get props => [];
}

class Loading extends LoyaltyState {
  @override
  List<Object> get props => [];
}

class Success extends LoyaltyState {
  @override
  List<Object> get props => [];
}

class Failed extends LoyaltyState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
