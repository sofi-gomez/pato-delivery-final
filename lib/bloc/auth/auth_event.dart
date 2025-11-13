import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// 🔹 Escucha cambios de sesión (login automático si ya hay usuario)
class AuthSubscriptionRequested extends AuthEvent {
  const AuthSubscriptionRequested();
}

/// 🔹 Login manual
class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

/// 🔹 Registro de nuevo usuario
class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthRegisterRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

/// 🔹 Cierre de sesión
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
