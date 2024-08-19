part of 'character_bloc.dart';

@immutable
sealed class CharacterEvent {}

class GetAllCharactersEvent extends CharacterEvent {
  final int page;
  final bool isFirstCall;

  GetAllCharactersEvent({
    required this.page,
     this.isFirstCall = false,
  });
}

class GetCharactersByIdEvent extends CharacterEvent {
  final int id;

  GetCharactersByIdEvent({required this.id});
}

class GetCharacterEpisodeEvent extends CharacterEvent {}
