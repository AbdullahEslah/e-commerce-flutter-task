class Validation {
  static bool? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    // Basic email regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(value);
    final hasDigit = RegExp(r'\d').hasMatch(value);

    if (!hasLetter) {
      return 'Password must contain at least one letter';
    }

    if (!hasDigit) {
      return 'Password must contain at least one number';
    }

    //  if passed all
    return "valid"; // Password is valid
  }
}
