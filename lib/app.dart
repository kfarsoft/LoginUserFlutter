import 'package:flutter/material.dart';
import 'package:flutterUser/auth/auth_bloc.dart';
import 'package:flutterUser/auth/auth_state.dart';
import 'package:flutterUser/screen/home_page.dart';
import 'package:flutterUser/screen/login_page.dart';
import 'package:flutterUser/screen/splash_screen.dart';
import 'package:flutterUser/services/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return SplashScreen();
          }
          if (state is AuthFailure) {
            return LoginPage(userRepository: _userRepository);
          }
          if (state is AuthSuccess) {
            return HomeScreen(email: state.email);
          }
          return SplashScreen();
        },
      ),
    );
  }
}
