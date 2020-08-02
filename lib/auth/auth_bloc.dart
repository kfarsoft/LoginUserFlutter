import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterUser/auth/auth_event.dart';
import 'package:flutterUser/services/user_repository.dart';
import 'package:meta/meta.dart';

import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthStarted) {
      yield* _mapAuthStartedToState();
    } else if (event is AuthLoggedIn) {
      yield* _mapAuthLoggedInToState();
    } else if (event is AuthLoggedOut) {
      yield* _mapAuthLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAuthStartedToState() async* {
    final isAuth = await _userRepository.isAuthenticated();
    if (isAuth) {
      final email = _userRepository.getEmail();
      yield AuthSuccess(email);
    } else {
      yield AuthFailure();
    }
  }

  Stream<AuthState> _mapAuthLoggedInToState() async* {
    yield AuthSuccess(_userRepository.getEmail());
  }

  Stream<AuthState> _mapAuthLoggedOutToState() async* {
    _userRepository.signOut();
    yield AuthFailure();
  }
}
