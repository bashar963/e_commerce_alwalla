part of 'product_details_bloc.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();
}

class ProductDetailsInitial extends ProductDetailsState {
  @override
  List<Object> get props => [];
}

class Loading extends ProductDetailsState {
  @override
  List<Object> get props => [];
}

class Success extends ProductDetailsState {
  @override
  List<Object> get props => [];
}

class Failed extends ProductDetailsState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
