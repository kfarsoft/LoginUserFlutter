import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = new Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  Preferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // Token
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // Id
  get id {
    return _prefs.getString('id') ?? '';
  }

  set id(String value) {
    _prefs.setString('id', value);
  }

// Email
  get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  clear() {
    _prefs.remove('id');
    _prefs.remove('email');
    _prefs.remove('token');
  }
}
