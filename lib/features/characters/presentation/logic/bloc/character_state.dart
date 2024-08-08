part of 'character_bloc.dart';

@immutable
sealed class CharacterState {}

final class CharacterInitialState extends CharacterState {}

final class CharacterLoadingState extends CharacterState {}

final class CharacterLoadedState extends CharacterState {
  final CharacterModel characterModel;

  CharacterLoadedState({required this.characterModel});
}

final class CharacterErrorState extends CharacterState {
  final CatchException error;

  CharacterErrorState({required this.error});
}

final class CharacterLoadedInfoState extends CharacterState {
  final CharacterResult result;

  CharacterLoadedInfoState({required this.result});
}
