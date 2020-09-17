part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class Loading extends LoginState {
  @override
  List<Object> get props => [];
}

class Success extends LoginState {
  @override
  List<Object> get props => [];
}

class Failed extends LoginState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
