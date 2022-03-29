enum Letter {
  A,
  B,
  C,
  D,
  E,
  F,
  G,
  H,
  I,
  J,
  K,
  L,
  M,
  N,
  O,
  P,
  Q,
  R,
  S,
  T,
  U,
  V,
  W,
  X,
  Y,
  Z,
}

extension LetterExt on Letter {
  String get value {
    return toString().split(".")[1];
  }

  static Letter valueOf(String letter) {
    assert(letter.length == 1);
    return Letter.values.firstWhere((element) => (element.value == letter));
  }
}

extension ListLetterExt on List<Letter> {
  String get joinedValue {
    return map((e) => e.value).join();
  }
}