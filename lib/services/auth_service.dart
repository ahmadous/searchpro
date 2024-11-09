import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Connexion d'un utilisateur existant
  Future<AppUser?> signIn(String email, String password) async {
    firebase_auth.UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _getUserFromFirestore(userCredential.user!.uid);
  }

  // Enregistrement d'un nouvel utilisateur
  Future<AppUser?> register(String email, String password, {String role = 'user'}) async {
    firebase_auth.UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Ajouter les informations de l'utilisateur dans Firestore
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'email': email,
      'role': role,
    });

    return _getUserFromFirestore(userCredential.user!.uid);
  }

  // Récupérer les informations d'un utilisateur dans Firestore
  Future<AppUser?> _getUserFromFirestore(String userId) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return AppUser.fromMap(userId, doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Déconnexion de l'utilisateur
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Envoi d'un email pour la réinitialisation de mot de passe
  Future<void> recoverPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
