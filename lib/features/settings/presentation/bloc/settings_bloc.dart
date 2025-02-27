import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_inventory_app/features/settings/data/datasources/settings_local_data_source.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsLocalDataSource settingsLocalDataSource;

  SettingsBloc({required this.settingsLocalDataSource})
    : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleTheme>(_onToggleTheme);
    on<ChangeColorPalette>(_onChangeColorPalette);
  }

  SettingsLoaded get _currentState {
    if (state is SettingsLoaded) {
      return state as SettingsLoaded;
    } else {
      return SettingsLoaded(false, Colors.blue); // Estado por defecto
    }
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    final isDarkMode = await settingsLocalDataSource.getThemeMode();
    final selectedColor = await settingsLocalDataSource.getSelectedColor();
    emit(SettingsLoaded(isDarkMode, selectedColor));
  }

  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<SettingsState> emit,
  ) async {
    await settingsLocalDataSource.saveThemeMode(event.isDarkMode);
    emit(SettingsLoaded(event.isDarkMode, _currentState.color));
  }

  Future<void> _onChangeColorPalette(
    ChangeColorPalette event,
    Emitter<SettingsState> emit,
  ) async {
    await settingsLocalDataSource.saveSelectedColor(event.color);
    emit(SettingsLoaded(_currentState.isDarkMode, event.color));
  }
}
