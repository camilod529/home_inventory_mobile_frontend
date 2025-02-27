// settings_state.dart
part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final bool isDarkMode;
  final Color color;
  SettingsLoaded(this.isDarkMode, this.color);
  @override
  List<Object> get props => [isDarkMode, color];
}
