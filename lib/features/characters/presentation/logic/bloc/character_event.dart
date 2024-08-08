part of 'character_bloc.dart';

@immutable
sealed class CharacterEvent {}

class GetAllCharacters extends CharacterEvent {}

class GetCharactersById extends CharacterEvent {
  final int id;

  GetCharactersById({required this.id});
}
