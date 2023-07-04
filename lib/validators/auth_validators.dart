String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty || !value.contains('@')) {
    return 'Invalid email address.';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.length < 6) {
    return 'Password must have 6 or more characters.';
  }
  return null;
}
