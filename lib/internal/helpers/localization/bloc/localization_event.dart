part of 'localization_bloc.dart';

@immutable
sealed class LocalizationEvent {}

class ChangeLocaleEvent extends LocalizationEvent {
   final String locale;

  ChangeLocaleEvent({required this.locale});

 
}
