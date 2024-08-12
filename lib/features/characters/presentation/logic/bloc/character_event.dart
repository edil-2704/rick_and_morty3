part of 'character_bloc.dart';

@immutable
sealed class CharacterEvent {}

class GetAllCharactersEvent extends CharacterEvent {}

class GetCharactersByIdEvent extends CharacterEvent {
  final int id;

  GetCharactersByIdEvent({required this.id});
}

class GetCharacterEpisodeEvent extends CharacterEvent {}
