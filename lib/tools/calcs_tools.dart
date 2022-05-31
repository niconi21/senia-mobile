import 'package:senia_app/configs/app_enviromets.dart';
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
        type.image = letter.image;
        letters.add(type);
      });
    });
    return letters;
  }

  static List<LetterModel> getLettersUser(List<LetterModel> letters) {
    List<LetterModel> lettersSeparated = [];

    letters.forEach((letter) {
      final hands = getTotalHandsInLetters(letter);
      lettersSeparated.addAll(hands);
    });

    return lettersSeparated;
  }

  static List<LetterModel> getLetterForRegister(List<LetterModel> letters) {
    final lettersUser = getLettersUser(letters);
    final lettersApp = getLettersApp();
    lettersUser.forEach((letterUser) {
      final index = lettersApp.indexWhere((letterApp) =>
          letterApp.name == letterUser.name &&
          letterApp.hand == letterUser.hand);
      if (index != -1) {
        lettersApp.removeAt(index);
      }
    });

    final Map<String, LetterModel> lettersAux = {};

    lettersApp.forEach((letter) {
      if (!lettersAux.containsKey(letter.name)) {
        lettersAux.addAll({
          letter.name: LetterModel.name(name: letter.name, image: letter.image)
        });
      }
      lettersAux[letter.name]!.hands.add(letter);
    });

    return List<LetterModel>.from(lettersAux.values);
  }

  static List<LetterModel> getLettersApp() {
    final List<LetterModel> letters = [];
    AppEnviroment.LETTERS.forEach((letter) {
      AppEnviroment.HANDS_LETTER.forEach((hand) {
        letters.add(LetterModel.nameAndHand(
            name: letter,
            hand: hand,
            image: '${AppEnviroment.PATH_IMAGES_LETTERS}/$letter.png'));
      });
    });

    return letters;
  }
}
