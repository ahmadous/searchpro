import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<AppUser> _users = [];

  List<AppUser> get users => _users;

  // Récupérer tous les utilisateurs depuis Firestore
  Future<void> fetchAllUsers() async {
    QuerySnapshot snapshot = await _firestore.collection('users').get();
    _users = snapshot.docs
        .map((doc) => AppUser.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }
  // Méthode pour récupérer les informations d'un utilisateur par ID
  Future<AppUser?> fetchUserById(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return AppUser.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Méthode pour mettre à jour le profil de l'utilisateur
  Future<void> updateUserProfile(String userId, String name, String email) async {
    await _firestore.collection('users').doc(userId).update({
      'name': name,
      'email': email,
    });
    notifyListeners();
  }
  // Mettre à jour le rôle d'un utilisateur
  Future<void> updateUserRole(String userId, String newRole) async {
    await _firestore.collection('users').doc(userId).update({'role': newRole});
    await fetchAllUsers(); // Rafraîchir la liste après modification
  }

  // Supprimer un utilisateur
  Future<void> deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
    await fetchAllUsers(); // Rafraîchir la liste après suppression
  }
}
