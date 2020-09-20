part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
}

class OrdersInitial extends OrdersState {
  @override
  List<Object> get props => [];
}

class Loading extends OrdersState {
  @override
  List<Object> get props => [];
}

class Success extends OrdersState {
  @override
  List<Object> get props => [];
}

class Failed extends OrdersState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
