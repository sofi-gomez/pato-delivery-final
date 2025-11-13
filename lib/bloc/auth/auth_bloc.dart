import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthBloc(this._firebaseAuth) : super(const AuthState.unknown()) {
    on<AuthSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  /// 🔹 Verifica si el usuario ya está autenticado
  Future<void> _onSubscriptionRequested(
      AuthSubscriptionRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(const AuthState.unknown());
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      emit(const AuthState.authenticated());
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  /// 🔹 Inicio de sesión con email y contraseña
  Future<void> _onLoginRequested(
      AuthLoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(const AuthState.unknown());
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(const AuthState.authenticated());
    } on FirebaseAuthException catch (e) {
      print('⚠️ Error de login: ${e.message}');
      emit(const AuthState.unauthenticated());
    } catch (e) {
      print('⚠️ Error inesperado: $e');
      emit(const AuthState.unauthenticated());
    }
  }

  /// 🔹 Registro de nuevo usuario
  Future<void> _onRegisterRequested(
      AuthRegisterRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(const AuthState.unknown());
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(const AuthState.authenticated());
    } on FirebaseAuthException catch (e) {
      print('⚠️ Error al registrar usuario: ${e.message}');
      emit(const AuthState.unauthenticated());
    } catch (e) {
      print('⚠️ Error inesperado en registro: $e');
      emit(const AuthState.unauthenticated());
    }
  }

  /// 🔹 Cierre de sesión
  Future<void> _onLogoutRequested(
      AuthLogoutRequested event,
      Emitter<AuthState> emit,
      ) async {
    await _firebaseAuth.signOut();
    emit(const AuthState.unauthenticated());
  }
}
