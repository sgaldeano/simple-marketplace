class LoginFormValidator {

  static String? validateEmail(String? email) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp  = RegExp(pattern);

    return regExp.hasMatch(email ?? '')
      ? null
      : 'Incorrect email format';
  }

  static String? validatePassword(String? password) {
    return (password != null && password.length >= 6)
      ? null
      : 'The Password must have at least 6 characters';
  }

}