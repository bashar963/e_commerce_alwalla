part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}

class Loading extends AccountState {
  @override
  List<Object> get props => [];
}

class Success extends AccountState {
  @override
  List<Object> get props => [];
}

class Failed extends AccountState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
