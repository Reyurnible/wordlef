import 'package:flutter/material.dart';

class KeyItemTheme {
  static const double _keyItemWidthThreshold = 400;
  static const double minimumLetterKeyItemWidth = 30;
  static const double largeLetterKeyItemWidth = 36;
  static const double keyItemHeight = 48;

  static const EdgeInsets margin = EdgeInsets.all(2);

  static double letterKeyItemWidth(context) {
    // 画面サイズの取得
    final Size size = MediaQuery.of(context).size;
    // 横幅で判断
    if (size.width < _keyItemWidthThreshold) {
      return minimumLetterKeyItemWidth;
    } else {
      return largeLetterKeyItemWidth;
    }
  }

  static double enterDelKeyItemWidth(context) {
    return letterKeyItemWidth(context) * 1.5;
  }
}
