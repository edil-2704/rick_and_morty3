import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';

String? statusConverter(Status status) {
  switch (status) {
    case Status.ALIVE:
      return 'Alive';

    case Status.DEAD:
      return 'Dead';

    default:
      return 'Неизвестный статус';
  }
}

String? genderConverter(Gender gender) {
  switch (gender) {
    case Gender.FEMALE:
      return 'Женский';

    case Gender.MALE:
      return 'Мужской';
    case Gender.UNKNOWN:
      return 'Неизвестный';

    default:
      return 'Неизвестный персонаж';
  }
}

String? speciesConverter(Species species) {
  switch (species) {
    case Species.ALIEN:
      return 'Чужой';

    case Species.HUMAN:
      return 'Человек';

    default:
      return 'Неизвестное существо';
  }
}