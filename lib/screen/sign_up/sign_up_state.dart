part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class Loading extends SignUpState {
  @override
  List<Object> get props => [];
}

class Success extends SignUpState {
  @override
  List<Object> get props => [];
}

class Failed extends SignUpState {
  final String error;

  Failed(this.error);
  @override
  List<Object> get props => [error];
}
