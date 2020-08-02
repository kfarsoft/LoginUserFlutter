import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final String email;

  const AuthSuccess(this.email);

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'AuthSuccess { email: $email }';
}

class AuthFailure extends AuthState {}
