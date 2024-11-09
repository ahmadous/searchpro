import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  AppUser? _user;

  AppUser? get user => _user;
  String? get role => _user?.role;

  // Connexion
  Future<void> signIn(String email, String password) async {
    _user = await _authService.signIn(email, password);
    notifyListeners();
  }

  // Enregistrement
  Future<void> register(String email, String password, {String role = 'user'}) async {
    _user = await _authService.register(email, password, role: role);
    notifyListeners();
  }

  // Déconnexion
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }

  // Réinitialisation de mot de passe
  Future<void> recoverPassword(String email) async {
    await _authService.recoverPassword(email);
  }
}
