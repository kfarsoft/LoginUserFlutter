import 'package:flutter/material.dart';
import 'package:flutterUser/screen/signup_screen.dart';
import 'package:flutterUser/services/user_repository.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return SignupScreen(userRepository: _userRepository);
          }),
        );
      },
    );
  }
}
