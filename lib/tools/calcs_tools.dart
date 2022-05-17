import 'package:senia_app/models/models.dart';

class CalcsTools {
  static double getPromedioPorcentageLetter(LetterModel letter) {
    double prom = 0;
    int count = 0;
    letter.hands.forEach((hand) {
      hand.types.forEach((type) {
        prom += type.percentage;
        count++;
      });
    });
    return prom / count;
  }

  static List<LetterModel> getTotalHandsInLetters(LetterModel letter) {
    List<LetterModel> letters = [];
    letter.hands.forEach((hand) {
      hand.types.forEach((type) {
        letters.add(type);
      });
    });
    return letters;
  }

  static List<LetterModel> getLetters(List<LetterModel> letters) {
    List<LetterModel> lettersSeparated = [];

    letters.forEach((letter) {
      final hands = getTotalHandsInLetters(letter);
      lettersSeparated.addAll(hands);
    });

    return lettersSeparated;
  }
}
