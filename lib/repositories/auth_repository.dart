import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository({FirebaseAuth? firebaseAuth})
      : _auth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  // Escucha el estado de autenticación (usuario logueado o no)
  Stream<User?> userChanges() => _auth.authStateChanges();

  // Usuario actual
  User? get currentUser => _auth.currentUser;

  // Iniciar sesión
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // Registrarse
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  // Cerrar sesión
  Future<void> signOut() => _auth.signOut();
}
