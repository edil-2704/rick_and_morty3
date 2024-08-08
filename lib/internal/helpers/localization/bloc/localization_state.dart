part of 'localization_bloc.dart';

@immutable
sealed class LocalizationState {}

final class LocalizationInitialState extends LocalizationState {}

class LocalizationLoadingState extends LocalizationState {}

class LocalizationLoadedState extends LocalizationState {
  final String updatedLocale;

  LocalizationLoadedState({required this.updatedLocale});
}

class LocalizationErrorState extends LocalizationState {}
