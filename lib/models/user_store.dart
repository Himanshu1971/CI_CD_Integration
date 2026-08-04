class UserStore {
  // Singleton so the same instance is shared across the app
  UserStore._internal();
  static final UserStore instance = UserStore._internal();

  String? _registeredEmail;
  String? _registeredPassword;
  final List<String> items = [];

  void signUp(String email, String password) {
    _registeredEmail = email;
    _registeredPassword = password;
  }

  bool login(String email, String password) {
    return email == _registeredEmail && password == _registeredPassword;
  }

  bool get hasAccount => _registeredEmail != null;
}