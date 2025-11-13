import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../main.dart';
import 'login_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    // 🔹 Al iniciar la app, pedimos verificar el estado de autenticación
    context.read<AuthBloc>().add(const AuthSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        switch (state.status) {
          case AuthStatus.unknown:
          // 🔸 Mientras Firebase verifica si hay usuario logueado
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: Colors.amber),
              ),
            );

          case AuthStatus.authenticated:
          // 🔸 Si hay sesión activa → ir al Home
            return const MainScreen();

          case AuthStatus.unauthenticated:
          default:
          // 🔸 Si no hay sesión → ir al Login
            return const LoginScreen();
        }
      },
    );
  }
}
