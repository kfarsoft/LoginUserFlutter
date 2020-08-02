import 'package:flutter/material.dart';
import 'package:flutterUser/app.dart';
import 'package:flutterUser/services/preferences.dart';
import 'package:flutterUser/services/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'auth/auth_bloc.dart';
import 'auth/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocObserver();
  final prefs = new Preferences();
  await prefs.initPrefs();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) =>
          AuthBloc(userRepository: userRepository)..add(AuthStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}
