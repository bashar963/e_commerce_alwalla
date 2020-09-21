part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();
}

class WishlistInitial extends WishlistState {
  @override
  List<Object> get props => [];
}

class Loading extends WishlistState {
  @override
  List<Object> get props => [];
}

class Success extends WishlistState {
  @override
  List<Object> get props => [];
}

class Failed extends WishlistState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
