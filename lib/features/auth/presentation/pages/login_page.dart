import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_bloc.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_event.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_state.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InventoryBloc, InventoryState>(
        listener: (context, inventoryState) {
          if (inventoryState is InventoryLoaded) {
            if (inventoryState.inventories.isNotEmpty) {
              context.go('/inventory-list');
            } else {
              context.go('/create-inventory');
            }
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, authState) {
                if (authState is AuthAuthenticated) {
                  context.read<InventoryBloc>().add(LoadUserInventories());
                } else if (authState is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(authState.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, authState) {
                return _LoginForm(
                  formKey: _formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Login",
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
                return "email is required";
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return "Invalid email";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'password',
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'password is required';
              }
              if (value.length < 6) {
                return 'password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Botón de login con estado de carga
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      state is AuthLoading
                          ? null // Deshabilitar si está cargando
                          : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                LoginRequested(
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
                          : const Text("Login", style: TextStyle(fontSize: 16)),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Link para registrarse
          TextButton(
            onPressed: () => context..go('/register'),
            child: const Text("Don't have an account? Register"),
          ),
        ],
      ),
    );
  }
}
