import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_inventory_app/features/settings/presentation/bloc/settings_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Lista de opciones de colores para la paleta.
  final List<Color> colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  @override
  void initState() {
    super.initState();
    // Despachamos el evento para cargar las configuraciones actuales.
    context.read<SettingsBloc>().add(LoadSettings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Sección para alternar el tema oscuro/claro.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tema Oscuro', style: TextStyle(fontSize: 18)),
                      Switch(
                        value: state.isDarkMode,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(ToggleTheme(value));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Sección para seleccionar la paleta de colores.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Color Primario',
                        style: TextStyle(fontSize: 18),
                      ),
                      DropdownButton<Color>(
                        value: state.color,
                        items:
                            colorOptions.map((Color color) {
                              return DropdownMenuItem<Color>(
                                value: color,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  color: color,
                                ),
                              );
                            }).toList(),
                        onChanged: (Color? newColor) {
                          if (newColor != null) {
                            context.read<SettingsBloc>().add(
                              ChangeColorPalette(newColor),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          // Mientras se cargan las configuraciones, muestra un indicador de carga.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
