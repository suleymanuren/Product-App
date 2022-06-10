extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

// ignore: camel_case_extensions
extension validateStructure on String {
  bool isValidPassword() {
    String pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{6,20}$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(this);
  }
}
