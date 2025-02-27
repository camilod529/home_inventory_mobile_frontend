part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSettings extends SettingsEvent {}

class ToggleTheme extends SettingsEvent {
  final bool isDarkMode;
  ToggleTheme(this.isDarkMode);
  @override
  List<Object> get props => [isDarkMode];
}

class ChangeColorPalette extends SettingsEvent {
  final Color color;
  ChangeColorPalette(this.color);
  @override
  List<Object> get props => [color];
}
