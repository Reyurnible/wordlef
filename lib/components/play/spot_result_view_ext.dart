import 'package:flutter/material.dart';

import '../../domain/model/spot_result.dart';

extension SpotResultViewExt on SpotResult {
  Color get color {
    switch (this) {
      case SpotResult.unknown:
        return const Color(0xFFD3D6DA);
      case SpotResult.correctSpot:
        return const Color(0xFF6AAA64);
      case SpotResult.wrongSpot:
        return const Color(0xFFC9B458);
      case SpotResult.notInWord:
        return const Color(0xFF787C7E);
    }
  }
}