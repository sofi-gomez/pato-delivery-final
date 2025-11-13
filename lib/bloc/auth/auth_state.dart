import 'package:equatable/equatable.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;

  const AuthState._({this.status = AuthStatus.unknown});

  // 🔹 Constructores nombrados
  const AuthState.unknown() : this._(status: AuthStatus.unknown);

  const AuthState.authenticated() : this._(status: AuthStatus.authenticated);

  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object> get props => [status];
}
