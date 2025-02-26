import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                Navigator.pushReplacementNamed(context, '/home');
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return _RegisterForm(
                formKey: _formKey,
                emailController: emailController,
                fullNameController: fullNameController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.fullNameController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController fullNameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Registro",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // Email
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El email es obligatorio';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Ingrese un email válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Full Name
          TextFormField(
            controller: fullNameController,
            decoration: InputDecoration(
              labelText: 'Nombre completo',
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El nombre es obligatorio';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La contraseña es obligatoria';
              }
              if (value.length < 6) {
                return 'Debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Confirm Password
          TextFormField(
            controller: confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirmar contraseña',
              prefixIcon: const Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Debe confirmar la contraseña';
              }
              if (value != passwordController.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Botón de registro con estado de carga
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      state is AuthLoading
                          ? null
                          : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                RegisterRequested(
                                  name: fullNameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child:
                      state is AuthLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            "Registrarse",
                            style: TextStyle(fontSize: 16),
                          ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Link para ir a Login
          TextButton(
            onPressed: () => context.go('/login'),
            child: const Text("¿Ya tienes cuenta? Inicia sesión"),
          ),
        ],
      ),
    );
  }
}
