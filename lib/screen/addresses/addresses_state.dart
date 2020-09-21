part of 'addresses_bloc.dart';

abstract class AddressesState extends Equatable {
  const AddressesState();
}

class AddressesInitial extends AddressesState {
  @override
  List<Object> get props => [];
}

class Loading extends AddressesState {
  @override
  List<Object> get props => [];
}

class Success extends AddressesState {
  @override
  List<Object> get props => [];
}

class Failed extends AddressesState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
