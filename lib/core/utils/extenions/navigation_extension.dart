import 'package:flutter/material.dart';

extension NavigationExtensions on BuildContext {
  /// Go to a new screen (push)
  void push(Widget screen) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  /// Go to a new screen and remove all previous routes (pushReplacement)
  void pushReplacement(Widget screen) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  /// Go to a new screen and remove all previous stack (pushAndRemoveUntil)
  void pushAndRemoveAll(Widget screen) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }

  /// Pop back to previous screen
  void pop<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }
}
