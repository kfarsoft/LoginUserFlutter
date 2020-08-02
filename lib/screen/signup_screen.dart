import 'package:flutter/material.dart';
import 'package:flutterUser/common/signup_form.dart';
import 'package:flutterUser/services/user_repository.dart';
import 'package:flutterUser/signup/signup_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  final UserRepository _userRepository;

  SignupScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Center(
        child: BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(userRepository: _userRepository),
          child: SignupForm(),
        ),
      ),
    );
  }
}
