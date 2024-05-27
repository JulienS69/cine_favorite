import 'package:flutter/material.dart';

class AppTextStyles {
  //Default Font family used by app
  static const String fontFamily = 'Helvetica';

  /// Text style for body
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  /// Text style for title
  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  // Text style for content
  static const TextStyle content = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );
}
